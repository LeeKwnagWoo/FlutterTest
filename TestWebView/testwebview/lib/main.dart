import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'https://pas.mysmartcredit.co.kr/raon/main/main.jsp';
String launchUrl = 'https://pas.mysmartcredit.co.kr/raon/smns_g/smns_g0101_01.jsp';
String launchUrl_real = 'https://pas.mysmartcredit.co.kr/raon/smns_g/smns_g0101_01.jsp';
// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override

  Homepage createState() => new Homepage();
}

class Homepage extends State<MyApp>{
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Container(
        height: 1024,
        child: SafeArea(
          child: WillPopScope(
            onWillPop: () => _goBack(context),
            child: WebviewScaffold(
              userAgent: "RaonWhiteHat_Mobile",
              url:selectedUrl,
              javascriptChannels: jsChannels,
              mediaPlaybackRequiresUserGesture: false,

            )

          ),

        ),
      )
    );
  }

  Future<bool> _goBack(BuildContext context) async{
    if(await flutterWebViewPlugin.canGoBack()){
      flutterWebViewPlugin.goBack();
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }

  late StreamSubscription _onDestroy;

  // On urlChanged stream
  late StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  late StreamSubscription<WebViewStateChanged> _onStateChanged;

  late StreamSubscription<WebViewHttpError> _onHttpError;

  late StreamSubscription<double> _onProgressChanged;

  late StreamSubscription<double> _onScrollYChanged;

  late StreamSubscription<double> _onScrollXChanged;

  final _urlCtrl = TextEditingController(text: selectedUrl);

  final _codeCtrl = TextEditingController(text: 'window.navigator.userAgent');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _history = [];

  @override
  void initState() {
    super.initState();

    // flutterWebViewPlugin.close();

    _urlCtrl.addListener(() {
      selectedUrl = _urlCtrl.text;
    });

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Webview Destroyed')));
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {

      print("****************on ourchanged****************");
      print(url);
      if (url == launchUrl){
        launch(url);
      }
      // if (mounted) {
      //   setState(() {
      //   print(url);
      //   _history.add('onUrlChanged: $url');
      //   });
      // }
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
          if (mounted) {
            setState(() {
              _history.add('onProgressChanged: $progress');
            });
          }
        });

    _onScrollYChanged =
        flutterWebViewPlugin.onScrollYChanged.listen((double y) {
          if (mounted) {
            setState(() {
              _history.add('Scroll in Y Direction: $y');
            });
          }
        });

    _onScrollXChanged =
        flutterWebViewPlugin.onScrollXChanged.listen((double x) {
          if (mounted) {
            setState(() {
              _history.add('Scroll in X Direction: $x');
            });
          }
        });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          if (mounted) {
            setState(() {
              _history.add('onStateChanged: ${state.type} ${state.url}');
            });
          }
        });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
          if (mounted) {
            setState(() {
              _history.add('onHttpError: ${error.code} ${error.url}');
            });
          }
        });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }

}

// class _MyHomePageState extends State<> {
//   // Instance of WebView plugin
//   final flutterWebViewPlugin = FlutterWebviewPlugin();
//   // void initState() {
//   //   super.initState();
//   //   final flutterWebviewPlugin = new FlutterWebviewPlugin();
//   //   flutterWebviewPlugin.onUrlChanged.listen((String url) {
//   //     print("init State");
//   //     print(url);
//   //   });
//   // }
//   // On destroy stream
//   }
// }
