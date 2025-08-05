import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:velocity_net/modules/plans/repository/selectedapp.dart';

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
    pw.MemoryImage logoImage;
    try {
      final response = await http.get(Uri.parse(
        'https://cdn.melhorplano.net/backoffice/logos/98ad256e-d6b7-4934-8f2c-d874a6cc9514'
      )).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        logoImage = pw.MemoryImage(response.bodyBytes);
      } else {
        throw Exception('Falha ao carregar logo: Status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao carregar logo: $e');
      // Fallback para logo local
      final ByteData data = await rootBundle.load('assets/images/logo_fallback.png');
      logoImage = pw.MemoryImage(data.buffer.asUint8List());
    }

    // Conteúdo do PDF
    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(24),
        header: (pw.Context context) {
          return pw.Center(
            child: pw.Image(logoImage, height: 60),
          );
        },
        footer: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Divider(),
              pw.Text(
                'Página ${context.pageNumber} de ${context.pagesCount}',
                style: normalStyle.copyWith(fontSize: 8),
              ),
            ],
          );
        },
        build: (pw.Context context) => [
          pw.SizedBox(height: 12),
          pw.Center(
            child: pw.Text(
              'Resumo do Combo Selecionado',
              style: boldStyle.copyWith(fontSize: 14),
            ),
          ),
          pw.Divider(),

          // Seção de Internet
          if (combo.mega.isNotEmpty)
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 6),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Plano de Internet:',
                    style: boldStyle.copyWith(color: PdfColors.blue800),
                  ),
                  pw.Text(
                    '${combo.mega} Megas - R\$ ${combo.megaPrice},99',
                    style: normalStyle,
                  ),
                ],
              ),
            ),

          // Seção de Apps
          if (combo.apps.isNotEmpty) ...[
            pw.SizedBox(height: 8),
            pw.Text(
              'Apps/Streamings selecionados:',
              style: boldStyle.copyWith(color: PdfColors.blue800),
            ),
            pw.SizedBox(height: 4),
            ...combo.apps.map((app) {
              return pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 2),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('- ${app.name}', style: normalStyle),
                    // pw.Text('R\$ ${app.price},99', style: normalStyle),
                  ],
                ),
              );
            }).toList(),
          ],

          // Total
          pw.SizedBox(height: 12),
          pw.Divider(thickness: 1),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'TOTAL MENSAL:',
                style: boldStyle.copyWith(
                  color: PdfColors.green900,
                  fontSize: 12,
                ),
              ),
              pw.Text(
                'R\$ ${combo.total},99',
                style: boldStyle.copyWith(
                  color: PdfColors.green900,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          // Informações adicionais
          pw.SizedBox(height: 20),
          pw.Text(
            'Informações de Pagamento',
            style: boldStyle.copyWith(
              fontSize: 11,
              color: PdfColors.grey800,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            'O pagamento será realizado mensalmente conforme as opções disponíveis no ato da contratação.\n'
            'Este documento é apenas um resumo do combo selecionado.\n\n'
            'VelocityNet © ${DateTime.now().year} - Todos os direitos reservados.',
            style: normalStyle,
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
    throw Exception('Não foi possível gerar o PDF: ${e.toString()}');
  }
}