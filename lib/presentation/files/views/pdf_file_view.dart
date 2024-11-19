import 'package:bac_files_admin/core/resources/styles/padding_resources.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfFileView extends StatefulWidget {
  const PdfFileView({
    super.key,
    required this.file,
  });
  final BacFile file;

  @override
  State<PdfFileView> createState() => _PdfFileViewState();
}

class _PdfFileViewState extends State<PdfFileView> {
  int totalPages = 1;
  int currentPage = 1;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            getTotalPages();
            getCurrentPage();
          },
          onWebResourceError: (error) {
            print('Web resource error: ${error.description}');
          },
          onHttpError: (HttpResponseError error) {},
        ),
      );
    // Load the PDF URL
    controller.loadRequest(Uri.parse(widget.file.publicViewUrl()));
  }

  void goToNextPage() {
    controller.runJavaScript("goToNextPage();");
    getTotalPages();
    getCurrentPage();
  }

  void goToPrevPage() {
    controller.runJavaScript("goToPrevPage();");
    getTotalPages();
    getCurrentPage();
  }

  // Method to get total pages from JavaScript
  Future<void> getTotalPages() async {
    final totalPagesStr = await controller.runJavaScriptReturningResult("getTotalPages();");
    setState(() {
      totalPages = int.tryParse(totalPagesStr.toString()) ?? 0; // Parse the total pages
    });
  }

  // Method to get current page from JavaScript
  Future<void> getCurrentPage() async {
    final currentPageStr = await controller.runJavaScriptReturningResult("getCurrentPage();");
    setState(() {
      currentPage = int.tryParse(currentPageStr.toString()) ?? 1; // Parse the current page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleTextStyle: Theme.of(context).textTheme.labelLarge,
        title: Text(widget.file.title),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("$totalPages/$currentPage"),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(100), // Margin around the boundaries
              minScale: 0.3,
              maxScale: 5.0,
              child: WebViewWidget(controller: controller),
            ),
          ),

          ///
          Align(
            alignment: const Alignment(0.9, 0.9),
            child: FloatingActionButton(
              heroTag: "goToPrevPage",
              onPressed: goToPrevPage,
              foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.arrow_back),
            ),
          ),

          ///
          Align(
            alignment: const Alignment(-0.9, 0.9),
            child: FloatingActionButton(
              heroTag: "goToNextPage",
              onPressed: goToNextPage,
              foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
