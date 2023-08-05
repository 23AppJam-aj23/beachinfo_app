// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      title: "beachInfo",
      home: myPage(),
    );
  }
}

class myPage extends StatelessWidget {
  myPage({Key? key}) : super(key: key);

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://beach.wsuk.dev/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://beach.wsuk.dev/rander'));

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double notchHeight = MediaQuery.of(context).padding.top;

    double totalHeight = screenHeight - notchHeight;

    return SafeArea(
      child: SizedBox(
        width: totalHeight,
        // the most important part of this example
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
