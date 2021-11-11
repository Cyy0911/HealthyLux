import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfApi {
  static Future<File> generate(
      String name, calories, ingredient, instruction, imageUrl) async {
    final pdf = pw.Document();
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();
    final image = pw.MemoryImage(
      bytes,
    );
    const pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
    );
    pdf.addPage(
      pw.MultiPage(
          build: (
            context,
          ) =>
              <pw.Widget>[
                pw.Row(
                  children: [
                    pw.PdfLogo(),
                    pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
                    pw.Text("HealthyLux",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                          color: PdfColors.black,
                        )),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Image(
                  image,
                  width: pageTheme.pageFormat.availableWidth / 1,
                  height: 300,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  name,
                  style: pw.TextStyle(
                    decoration: pw.TextDecoration.underline,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  calories,
                  style: pw.TextStyle(
                    decoration: pw.TextDecoration.underline,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "Ingredients:",
                  style: pw.TextStyle(
                    decoration: pw.TextDecoration.underline,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  ingredient,
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "Instructions:",
                  style: pw.TextStyle(
                    decoration: pw.TextDecoration.underline,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  instruction,
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
              ],
          footer: (context) {
            final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
              child: pw.Text(
                text,
                style: const pw.TextStyle(color: PdfColors.black),
              ),
            );
          }),
    );
    return saveDocument(name: name, pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
