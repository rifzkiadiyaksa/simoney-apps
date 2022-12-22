import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';

class WebViewScreen extends StatefulWidget {
  String? url,judul ;
   WebViewScreen({Key? key, this.url, this.judul}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  final flutterWebViewPlugin = FlutterWebviewPlugin();
  late StreamSubscription<double> _onPageProgress;
  late StreamSubscription<String> _onUrlChanged;
  progessChange(double event) {
    print("Page loading " + event.toString());
    if (event == 1.0) {
      flutterWebViewPlugin.show();
    } else {
      flutterWebViewPlugin.hide();
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onPageProgress =
        flutterWebViewPlugin.onProgressChanged.listen(progessChange);
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) async {
      if(this.mounted){
        print(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text("${widget.judul!}"),
        backgroundColor: Color(0xff536D6C),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
        url: widget.url!,
      hidden: false,
      ignoreSSLErrors: true,
      withZoom: true,
      displayZoomControls: true,
      withJavascript: true,
      initialChild: Container(
        color: Colors.black,
        child:  Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
            )
        ),
      ),
    );
  }
}
