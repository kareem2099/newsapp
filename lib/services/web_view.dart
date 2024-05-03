// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewPage extends StatefulWidget {
//   final String url;

//   WebViewPage({required this.url});

//   @override
//   State<WebViewPage> createState() => _WebViewPageState();
// }

// class _WebViewPageState extends State<WebViewPage> {
//   final _controller = Completer<WebViewController>();
//   double _progress = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('News Article'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Column(
//         children: [
//           // Progress bar
//           LinearProgressIndicator(value: _progress),
//           // WebView
//           Expanded(
//             child: WebView(
//               initialUrl: widget.url,
//               javascriptMode: JavaScriptMode.unrestricted,
//               onWebViewCreated: (controller) {
//                 _controller.complete(controller);
//               },
//               onPageStarted: (url) {
//                 setState(() {
//                   _progress = 0;
//                 });
//               },
//               onPageFinished: (url) {
//                 setState(() {
//                   _progress = 1;
//                 });
//               },
//               onProgress: (progress) {
//                 setState(() {
//                   _progress = progress / 100;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
