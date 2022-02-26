import 'dart:io';
import 'dart:typed_data';
import 'package:edutube/components/theme.dart';
import 'package:edutube/pdf/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class Pdf_Template extends StatefulWidget {
  @override
  State<Pdf_Template> createState() => _Pdf_TemplateState();
}

class _Pdf_TemplateState extends State<Pdf_Template> {
  final pdf = pw.Document();
String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File receiptFile = File("$documentPath/example.pdf");
    receiptFile.writeAsBytesSync(List.from(await pdf.save()));
  }

  var profileImage;

  @override
  void initState() {
    doSomeAsyncStuff();

    super.initState();
  }

  Future<void> doSomeAsyncStuff() async {
    profileImage = pw.MemoryImage(
        (await rootBundle.load('assets/onboard/border.png'))
            .buffer
            .asUint8List());
  }

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(32),
      // pageTheme: pw.PageTheme(),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Container(
            color: PdfColors.teal200,
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  // pw.Header(
                  // level: 0,
                  pw.SizedBox(height: 4.0),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: <pw.Widget>[
                        pw.Text('EduTube',
                            textScaleFactor: 1,
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                color: PdfColors.red, letterSpacing: 2.0)),
                      ]),
                  // ),
                  pw.SizedBox(height: 3.0),
                  pw.Center(
                    child: pw.Image(profileImage, width: 110),
                  ),
                  pw.SizedBox(height: 4.0),
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                      // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Center(
                            child: pw.Text('CERTIFICATE OF COMPLETION',
                                textScaleFactor: 1.2,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    color: PdfColors.black,
                                    fontWeight: pw.FontWeight.bold,
                                    letterSpacing: 2)),
                          ),
                        )
                      ]),
                  // pw.Header(level: 1, text: 'What is Lorem Ipsum?'),
                  pw.SizedBox(height: 10.0),
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                      // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Center(
                          child: pw.Text('IS HEREBY GRANTED TO',
                              textScaleFactor: 1,
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.red,
                                  fontWeight: pw.FontWeight.bold,
                                  letterSpacing: 2.0)),
                        )
                      ]),
                  pw.SizedBox(height: 15.0),
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                      // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Center(
                          child: pw.Text('NAME',
                              textScaleFactor: 2,
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontWeight: pw.FontWeight.bold,
                                  letterSpacing: 4.0)),
                        )
                      ]),
                  pw.SizedBox(height: 15.0),
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                      // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Flexible(
                          child: pw.Center(
                            child: pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text('Hello',
                                  textScaleFactor: 2,
                                  // overflow: pw.TextOverflow.clip,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                      color: PdfColors.black,
                                      fontWeight: pw.FontWeight.bold,
                                      letterSpacing: 4.0)),
                            ),
                          ),
                        )
                      ]),
                  pw.SizedBox(height: 15.0),
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Header(level: 1, text: 'Siign'),
                        pw.Header(level: 1, text: 'Date: ${date}'),
                      ]),
                  // Write All the paragraph in one line.
                  // For clear understanding
                  // here there are line breaks.

                  pw.Padding(padding: const pw.EdgeInsets.all(10)),
                ]),
          ),
        ];
      },
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Certificate"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blueGrey,
                child: Text(
                  'Preview PDF',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                onPressed: () async {
                  writeOnPdf();
                  await savePdf();

                  Directory documentDirectory =
                      await getApplicationDocumentsDirectory();

                  String documentPath = documentDirectory.path;

                  String fullPath = "$documentPath/example.pdf";
                  print(fullPath);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(
                                path: fullPath,
                              )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
