import 'package:flutter/material.dart';
import 'package:flutter_lapon/view/success_payment/success_payment_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../config/app_color.dart';



class PaymentWebviewPage extends StatefulWidget {
  const PaymentWebviewPage({super.key, required this.url, this.route});
  final String url;
  final dynamic route;

  @override
  State<PaymentWebviewPage> createState() => _PaymentWebviewPageState();
}

class _PaymentWebviewPageState extends State<PaymentWebviewPage> {
  late final WebViewController _controller;
  String urlMidtrans = "";

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
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
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            setState(() {
              urlMidtrans = url;
            });
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            setState(() {
              urlMidtrans = url;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // debugPrint("ini url nya ya ${request.url}");
            setState(() {
              urlMidtrans = request.url;
            });
            if (request.url.contains('return-webhook')){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => SuccessPaymentPage(status: request.url.split('=')[3])),
                      (Route<dynamic> route) => false);
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
            setState(() {
              urlMidtrans = change.url ?? "";
            });
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.canGoBack().then((value) {
          if (value) {
            _controller.goBack();
          } else {
            if (urlMidtrans.contains(widget.url)){
              paymentConfirm();
            } else if (urlMidtrans.contains('return-webhook')){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => SuccessPaymentPage(status: urlMidtrans.split('=')[3])),
                      (Route<dynamic> route) => false);
            } else {
              Navigator.pop(context);
            }
          }
        });
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(),
          appBar: AppBar(
            backgroundColor: AppColor.colorPrimaryGreen,
            title: Text(
              "Pembayaran",
              style: fontTextStyle.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  _controller.canGoBack().then((value) {
                    if (value) {
                      _controller.goBack();
                    } else {
                      debugPrint("ini url di wilpop $urlMidtrans");
                      if (urlMidtrans.contains(widget.url)){
                        paymentConfirm();
                      } else if (urlMidtrans.contains('return-webhook')){
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => SuccessPaymentPage(status: urlMidtrans.split('=')[3])),
                                (Route<dynamic> route) => false);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  });
                },
                icon: const Icon(Icons.arrow_back_ios), color: AppColor.black),
          ),
          body: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }

  Future paymentConfirm() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        contentPadding: EdgeInsets.zero,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Lanjutkan Pembayaran?",
                style: fontTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColor.black),
              ),
            ),
            const SizedBox(height: 14),
            Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: AppColor.colorPrimaryGreen))),
                child: Text(
                  "Apakah anda tidak ingin melanjutkan pembayaran?",
                  style: fontTextStyle.copyWith(
                      color: AppColor.black, fontSize: 13),
                )),
          ],
        ),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: const BorderSide(
                    color: AppColor.colorPrimaryGreen,
                  )),
              onPressed: () {
                // if (widget.route == "detail-pemesanan"){
                //   Navigator.pop(context);
                //   Navigator.pop(context);
                // } else {
                //   Navigator.of(context).pushAndRemoveUntil(
                //       MaterialPageRoute(builder: (_) => const SuccessPaymentPage(status: "pending")),
                //           (Route<dynamic> route) => false);
                // }

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const SuccessPaymentPage(status: "pending")),
                        (Route<dynamic> route) => false);

              },
              child: Text(
                'Batal',
                style: fontTextStyle.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.black),
              )),
          const SizedBox(width: 5),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
                backgroundColor: AppColor.colorPrimaryYellow,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                )),
            child: Text(
              "Lanjutkan",
              style: fontTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColor.white),
            ),
          ),
        ],
      ),
    );
  }
}

