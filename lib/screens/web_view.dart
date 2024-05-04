// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final WebViewController _controller = WebViewController();
  String pageTitle = '-';
  double progress = 0;

  @override
  void initState() {
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (p) {
          setState(() {
            progress = p / 100;
          });
        },
        onPageStarted: (url) {
          setState(() {
            pageTitle = 'loading....';
          });
        },
        onPageFinished: (url) {
          setState(() {
            pageTitle = url;
            progress = 0;
          });
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Article'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // Progress bar
          if (progress > 0 && progress < 1)
            LinearProgressIndicator(
              value: progress,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
              backgroundColor: Colors.teal,
            ),
          // WebView
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () async {
                    if (await _controller.canGoBack()) {
                      _controller.goBack();
                    }
                  },
                  icon: const Icon(Icons.arrow_back)),
              IconButton(
                  onPressed: () async {
                    _controller.reload();
                  },
                  icon: const Icon(Icons.replay_outlined)),
              IconButton(
                  onPressed: () async {
                    _controller.clearCache();
                  },
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () async {
                    if (await _controller.canGoForward()) {
                      _controller.goForward();
                    }
                  },
                  icon: const Icon(Icons.arrow_forward)),
            ],
          ),
        ],
      ),
    );
  }
}
