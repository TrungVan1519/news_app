import 'package:flutter/material.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/widgets/text_subtitle_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsOriginalDetailPage extends StatefulWidget {
  const NewsOriginalDetailPage({
    super.key,
    this.url,
  });

  final String? url;

  @override
  State<NewsOriginalDetailPage> createState() => _NewsOriginalDetailPageState();
}

class _NewsOriginalDetailPageState extends State<NewsOriginalDetailPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            context.pop();
            context.showSnackBar(error.description);
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  void dispose() {
    super.dispose();
    controller.clearCache();
    controller.clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: context.height,
          child: SafeArea(
            child: widget.url == null
                ? const Center(
                    child: TextSubtitleWidget(text: 'Cannot open this page'),
                  )
                : WebViewWidget(controller: controller),
          ),
        ),
      ),
    );
  }
}
