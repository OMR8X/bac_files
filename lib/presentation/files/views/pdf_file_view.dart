import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfFileView extends StatefulWidget {
  const PdfFileView({
    super.key,
    required this.url,
  });
  final String url;
  @override
  State<PdfFileView> createState() => _PdfFileViewState();
}

class _PdfFileViewState extends State<PdfFileView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfPdfViewer.network(widget.url),
    );
  }


}
