import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class SupportScreen extends StatefulWidget{

  const SupportScreen({super.key});

  @override
  State<StatefulWidget> createState() => SupportScreenState();

}

class SupportScreenState extends State<SupportScreen>{

  late final WebViewController _controller;
  
  @override
  void initState() {
   
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    
    final WebViewController controller =
      WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('Cargando... : $progress%');
          },
          onPageStarted: (String url) {
            debugPrint('Empezando carga: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Carga finalizada: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Error en la carga:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('Bloqueando navegación de: ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('Navegación permitida: ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error de la página: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('Url cambiada: ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            // debugPrint(request.);
          },
        ),
      )
      ..loadRequest(Uri.parse('https://support.bitdefenderecuador.com.ec/portal/es/newticket?departmentId=570205000000006907&layoutId=570205000000074011'));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;

  }

  @override
  Widget build(BuildContext context) {
    return  WebViewWidget(
      controller: _controller
    );
  }


}