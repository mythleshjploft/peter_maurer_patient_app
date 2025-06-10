import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/modules/login/login_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  // List of Onboarding Pages
  final List<OnboardPage> pages = [
    const OnboardPage(
      image: 'assets/images/onbording_img1.png',
      title: "Your Trusted Partner in Healthcare Management",
      description:
          "Effortlessly manage appointments, patients, and prescriptions—all in one place. Mourer Health makes healthcare seamless for both doctors and patients.",
    ),
    const OnboardPage(
      image: 'assets/images/onbording_img2.png',
      title: "Simplify Your Workflow, Enhance Patient Care",
      description:
          "From scheduling to medical records, Mourer Health helps doctors and patients stay organized with real-time updates and secure data access.",
    ),
    const OnboardPage(
      image: 'assets/images/onbording_img3.png',
      title: "Connect Anytime, Anywhere",
      description:
          "Chat with patients, conduct video consultations, and send prescriptions online. Stay accessible while maintaining compliance with top security standards.",
    ),
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: pages,
          ),
          // SmoothPageIndicator

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: pages.length,
                    effect: WormEffect(
                        dotHeight: 9,
                        dotWidth: 9,
                        activeDotColor: const Color(0xff2EB3D6),
                        dotColor: Colors.grey.shade200),
                    // effect: const ExpandingDotsEffect(
                    //   dotHeight: 4,
                    //   dotWidth: 4,

                    //   activeDotColor: Color(0xff2EB3D6),
                    // ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: _currentPage > 0
                            ? () {
                                _controller.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SvgPicture.asset(
                              "assets/icons/back_button_icon.svg"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (_currentPage == pages.length - 1) {
                            Get.to(const LoginView());
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: SvgPicture.asset(
                            "assets/icons/forword_button_icon.svg"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/images/custom_card_onbording.png"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff717171),
                          height: 1.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
