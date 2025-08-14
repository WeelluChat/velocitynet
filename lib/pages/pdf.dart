import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:velocity_net/modules/plans/repository/selectedapp.dart'; // Certifique-se que este import está correto para o seu projeto

// Função auxiliar para formatar os valores monetários, convertendo 109.99 para "109,99"
String _formatCurrency(num value) {
  return value.toStringAsFixed(2).replaceAll('.', ',');
}

Future<Uint8List> gerarPdfRelatorio(SelectedCombo combo) async {
  try {
    // Validação dos dados de entrada
    if (combo.mega.isEmpty && combo.apps.isEmpty) {
      throw Exception('Nenhum dado selecionado para gerar o PDF');
    }

    // Configurações do documento
    final pdf = pw.Document(
      title: 'Resumo do Combo Velocity',
      author: 'VelocityNet',
    );

    // Estilos reutilizáveis
    final boldStyle = pw.TextStyle(
      font: pw.Font.helveticaBold(),
      fontSize: 10,
    );

    final normalStyle = pw.TextStyle(
      font: pw.Font.helvetica(),
      fontSize: 10,
    );

    // Carregamento do logo com fallback
    pw.MemoryImage? logoImage; // Use nullable type
    try {
      final response = await http.get(Uri.parse(
              'https://cdn.melhorplano.net/backoffice/logos/98ad256e-d6b7-4934-8f2c-d874a6cc9514'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        logoImage = pw.MemoryImage(response.bodyBytes);
      } else {
        throw Exception('Falha ao carregar logo: Status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao carregar logo da web: $e. Usando logo local.');
    }
    
    // Fallback para logo local se o download falhar
    if (logoImage == null) {
       final ByteData data = await rootBundle.load('assets/images/logo_fallback.png'); // Verifique o caminho do seu logo local
       logoImage = pw.MemoryImage(data.buffer.asUint8List());
    }


    // Conteúdo do PDF
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme( // CORREÇÃO APLICADA AQUI
          margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          orientation: pw.PageOrientation.portrait,
        ),
        header: (pw.Context context) {
          return pw.Column(
            children: [
               pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                    pw.Image(logoImage!, height: 40),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('AVENIDA B, 23 QUADRA 298 - CIDADE JARDIM', style: normalStyle.copyWith(fontSize: 8)),
                        pw.Text('CEP: 68515-000 WhatsApp: (94) 991045810', style: normalStyle.copyWith(fontSize: 8)),
                        pw.Text('E-mail: FIBRANOSSA@FIBRANOSSA.COM', style: normalStyle.copyWith(fontSize: 8)),
                      ]
                    )
                ]
              ),
              pw.SizedBox(height: 20),
            ]
          );
        },
        footer: (pw.Context context) {
          // Adicione seu rodapé personalizado aqui se necessário
          return pw.Container();
        },
        build: (pw.Context context) => [
          pw.SizedBox(height: 20),
          pw.Center(
            child: pw.Text(
              'RESUMO DO COMBO SELECIONADO',
              style: boldStyle.copyWith(fontSize: 14),
            ),
          ),
          pw.SizedBox(height: 30),

          // Seção de Internet
          if (combo.mega.isNotEmpty)
            pw.Container(
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Plano de Internet:',
                    style: boldStyle.copyWith(color: PdfColors.blue700, fontSize: 11),
                  ),
                  pw.Text(
                    '${combo.mega} Megas',
                    style: boldStyle.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
          pw.SizedBox(height: 20),

          // Seção de Apps
          if (combo.apps.isNotEmpty) ...[
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                'Apps/Streamings selecionados:',
                style: boldStyle.copyWith(color: PdfColors.blue700, fontSize: 11),
              ),
            ),
            pw.SizedBox(height: 8),
            ...combo.apps.map((app) {
              return pw.Padding(
                padding: const pw.EdgeInsets.only(left: 10, top: 2, bottom: 2),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('- ${app.name}', style: normalStyle),
                    // pw.Text('R\$ ${_formatCurrency(app.price)}', style: normalStyle),
                  ],
                ),
              );
            }).toList(),
          ],

          pw.SizedBox(height: 20),

          // Total
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'TOTAL MENSAL:',
                style: boldStyle.copyWith(
                  color: PdfColors.black,
                  fontSize: 12,
                ),
              ),
              pw.Text(
                'R\$ ${_formatCurrency(combo.total)}',
                style: boldStyle.copyWith(
                  color: PdfColors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          // Informações adicionais
          pw.SizedBox(height: 40),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              'Informações de Pagamento:',
              style: boldStyle.copyWith(
                fontSize: 11,
                color: PdfColors.grey800,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              'O pagamento será realizado mensalmente conforme as opções disponíveis no '
              'ato da contratação. Este documento é apenas um resumo do combo selecionado.\n\n'
              'VelocityNet © ${DateTime.now().year} - Todos os direitos reservados.',
              style: normalStyle.copyWith(color: PdfColors.grey700),
            ),
          ),
        ],
      ),
    );

    // Geração do PDF
    final Uint8List pdfBytes = await pdf.save();

    // Validação do PDF gerado
    if (pdfBytes.isEmpty) {
      throw Exception('PDF gerado está vazio');
    }

    return pdfBytes;
  } catch (e, stackTrace) {
    debugPrint('Erro ao gerar PDF: $e');
    debugPrint('Stack trace: $stackTrace');
    // Em produção, você pode querer usar um sistema de logging mais robusto
    throw Exception('Não foi possível gerar o PDF: ${e.toString()}');
  }
}