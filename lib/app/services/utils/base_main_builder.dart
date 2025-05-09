// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:peter_maurer_patients_app/app/services/utils/customised_grey_screen.dart';

class BaseMainBuilder extends StatelessWidget {
  final BuildContext context;
  final Widget? child;
  const BaseMainBuilder({
    super.key,
    required this.context,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return CustomisedGreyErrorScreen(errorDetails: errorDetails);
    };
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: LoaderOverlay(
                    overlayColor: Colors.black.withOpacity(0.6),
                    overlayWidgetBuilder: (_) {
                      return const Center(
                        child: CircularProgressIndicator(),
                        // child: Lottie.asset(BaseAssets.loader, height: 200),
                      );
                    },
                    child: MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaler: const TextScaler.linear(1.0)),
                      child: child!,
                    ),
                  ),
                ),

                // StreamBuilder(
                //   stream: Connectivity().onConnectivityChanged,
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<ConnectivityResult>> connectivity) {
                //     return Visibility(
                //       visible: !(connectivity.data
                //                   ?.contains(ConnectivityResult.mobile) ??
                //               true) &&
                //           !(connectivity.data
                //                   ?.contains(ConnectivityResult.wifi) ??
                //               true),
                //       child: SizedBox(
                //         height: 25,
                //         child: Scaffold(
                //           backgroundColor: Colors.red,
                //           body: Visibility(
                //             visible: !(connectivity.data
                //                         ?.contains(ConnectivityResult.mobile) ??
                //                     true) &&
                //                 !(connectivity.data
                //                         ?.contains(ConnectivityResult.wifi) ??
                //                     true),
                //             child: Container(
                //               height: 25,
                //               color: (!(connectivity.data?.contains(
                //                               ConnectivityResult.mobile) ??
                //                           true) &&
                //                       !(connectivity.data?.contains(
                //                               ConnectivityResult.wifi) ??
                //                           true))
                //                   ? Colors.red
                //                   : Colors.green.shade800,
                //               width: MediaQuery.of(context).size.width,
                //               alignment: Alignment.center,
                //               child: Text("No Connection!".tr,
                //                   style: const TextStyle(
                //                     fontSize: 14,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w500,
                //                   )),
                //             ),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ],
        ));
  }
}
