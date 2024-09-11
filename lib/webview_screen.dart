import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://openweather.co.uk/about'),
      );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About Us"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
