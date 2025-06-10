import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/controllers/appointment_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';
import 'package:peter_maurer_patients_app/app/services/backend/api_end_points.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppointmentWebViewScreen extends StatefulWidget {
  final String url;
  final String? title;
  final String? callbackUrlPrefix;
  final void Function(String callbackUrl)? onCallbackUrl;

  const AppointmentWebViewScreen({
    super.key,
    required this.url,
    this.title,
    this.callbackUrlPrefix,
    this.onCallbackUrl,
  });

  @override
  State<AppointmentWebViewScreen> createState() =>
      _AppointmentWebViewScreenState();
}

class _AppointmentWebViewScreenState extends State<AppointmentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    log(widget.url);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => _isLoading = true);
          },
          onProgress: (progress) => log(progress.toString()),
          onPageFinished: (url) {
            log(url);
            setState(() => _isLoading = false);
          },
          onUrlChange: (url) {
            log(url.url ?? "");
            if ((url.url ?? "") != widget.url) {
              Future.delayed(const Duration(seconds: 1), () {
                Get.back();
                if ((url.url ?? "") == ApiEndPoints().callbackUrl) {
                  showSnackBar(
                      subtitle: "Form Submitted Successfully", isSuccess: true);
                  Get.find<AppointmentController>().selectedTab.value = 0;
                  Get.find<AppointmentController>().getAppointmentList();
                }
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            log(request.url);
            if (widget.callbackUrlPrefix != null &&
                request.url.contains(widget.callbackUrlPrefix!)) {
              widget.onCallbackUrl?.call(request.url);
              // Optionally stop loading the URL in WebView
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            // Optionally handle errors here
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    _controller.goBack();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title ?? 'Fill Form'),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
