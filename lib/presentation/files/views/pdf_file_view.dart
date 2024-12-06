import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PdfFileView extends StatefulWidget {
  const PdfFileView({
    super.key,
    required this.path,
  });
  final String path;

  @override
  State<PdfFileView> createState() => _PdfFileViewState();
}

class _PdfFileViewState extends State<PdfFileView> {
  int? pages;
  int? page = 1;
  int? total;
  PDFViewController? pdfViewController;
  initializeController(PDFViewController pdfViewController) async {
    this.pdfViewController = pdfViewController;
    total = await pdfViewController.getPageCount();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("اسم الملف"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$total/$page"),
          ),
        ],
        titleTextStyle: Theme.of(context).textTheme.labelLarge,
      ),
      body: PDFView(
        //
        filePath: widget.path,
        //
        enableSwipe: true,
        //
        pageFling: false,
        //
        backgroundColor: Colors.grey[800],
        //
        onRender: (pages) => setState(() => this.pages = pages),
        //
        onViewCreated: (PDFViewController pdfViewController) => initializeController(pdfViewController),
        //
        onPageChanged: (int? page, int? total) => setState(() {
          this.page = page;
          this.total = total;
        }),
        //
        onError: (error) {
          Fluttertoast.showToast(msg: "حصل خطا ما \nتفاصيل الخطا : $error");
        },
        onPageError: (page, error) {
          Fluttertoast.showToast(msg: "حصل خطا ما \nتفاصيل الخطا : $error");
        },
      ),
    );
  }
}
