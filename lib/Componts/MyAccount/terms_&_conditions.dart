

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsCondidtionweb extends StatelessWidget {
  TermsCondidtionweb({Key? key}) : super(key: key);
  WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))

  ..setNavigationDelegate(

  NavigationDelegate(
  onProgress: (int progress) {
  // Update loading bar.
  },
  onPageStarted: (String url) {},
  onPageFinished: (String url) {},
  onWebResourceError: (WebResourceError error) {},
  onNavigationRequest: (NavigationRequest request) {
  if (request.url.startsWith('https://www.youtube.com/')) {
  return NavigationDecision.prevent;
  }
  return NavigationDecision.navigate;
  },
  ),
  )
  ..loadRequest(Uri.parse('https://cropguru.in/index.php/tcenglish'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

            WebViewWidget(controller: controller,
              layoutDirection: TextDirection.ltr,

            ),
    );
  }

}
