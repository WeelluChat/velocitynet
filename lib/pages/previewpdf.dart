import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;
import 'package:velocity_net/modules/plans/repository/selectedapp.dart';
import 'package:velocity_net/pages/pdf.dart'; // Para suporte web universal

class PreviewPdf extends StatefulWidget {
  final SelectedCombo combo;

  const PreviewPdf({super.key, required this.combo});

  @override
  State<PreviewPdf> createState() => _PreviewPdfState();
}

class _PreviewPdfState extends State<PreviewPdf> {
  Future<void> _downloadPdf() async {
    try {
      final pdfBytes = await gerarPdfRelatorio(widget.combo);

      if (kIsWeb) {
        // Implementação para WEB
        final blob = html.Blob([pdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..download = 'resumo_velocity.pdf'
          ..style.display = 'none';
        
        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      } else {
        // Implementação para MOBILE/DESKTOP
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/resumo_velocity.pdf');
        await file.writeAsBytes(pdfBytes);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('PDF salvo em: ${file.path}'),
              action: SnackBarAction(
                label: 'Compartilhar',
                onPressed: () => Printing.sharePdf(
                  bytes: pdfBytes,
                  filename: 'resumo_velocity.pdf',
                ),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao baixar PDF: ${e.toString()}')),
        );
      }
      debugPrint('Erro em _downloadPdf: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prévia do PDF'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadPdf,
            tooltip: 'Baixar PDF',
          ),
        ],
      ),
      body: PdfPreview(
        build: (format) => gerarPdfRelatorio(widget.combo),
        canChangePageFormat: false,
        allowSharing: true,
        allowPrinting: true,
        pdfFileName: 'resumo_velocity.pdf',
      ),
    );
  }
}