import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:isar/isar.dart';

import '../hymn/app_initializer.dart';
import '../hymn/hymn_models.dart';

class PdfExportService {
  Future<void> exportHymns({
    required List<String> hymnIds,
  }) async {
    final isar = AppInitializer.isar;

    final hymns = await isar.localHymns
        .filter()
        .anyOf(
          hymnIds,
          (q, id) => q.hymnIdEqualTo(id),
        )
        .findAll();

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return hymns.map((hymn) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  hymn.title,
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 12),

                pw.Text(
                  hymn.originalLyrics,
                  style: const pw.TextStyle(
                    fontSize: 14,
                  ),
                ),

                pw.SizedBox(height: 30),

                pw.Divider(),
              ],
            );
          }).toList();
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'zion_songs_export.pdf',
    );
  }
}