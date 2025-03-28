import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_no_data.dart';

class CustomisedGreyErrorScreen extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const CustomisedGreyErrorScreen({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BaseNoData(
              message: kDebugMode
                  ? errorDetails.summary.toString()
                  : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
            )
          ],
        ),
      ),
    );
  }
}
