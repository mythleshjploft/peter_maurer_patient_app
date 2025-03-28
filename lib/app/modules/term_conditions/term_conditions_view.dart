import 'package:flutter/material.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';


class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Terms & Conditions"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to Peter-Maurer! By using our app, you agree to the following terms and conditions. Please read them carefully before booking an appointment.",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.6
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "By accessing or using Peter-Maurer, you acknowledge that you have read, understood, and agreed to be bound by these Terms and Conditions. If you do not agree, please do not use our services.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              const Text(
                "User Eligibility",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(height: 5),
              const Text(
                "You must be at least 18 years old or have parental/guardian consent to use our services. By using this app, you confirm that the information you provide is accurate and up to date.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              
              // List of Cancellation and Refund Policy
              Column(
                children: List.generate(4, (index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cancellation and Refund Policy",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Refunds, if applicable, will be processed based on the cancellation terms of the medical professional or clinic.",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
