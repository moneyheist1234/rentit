import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/splash.dart';
import '../../widgets/splash_widgets/pagination_dots.dart';
import '../../widgets/splash_widgets/primary_button.dart';
import '../login&signup/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of splash screen data
  final List<SplashScreenData> splashData = [
    SplashScreenData(
      imagePath: 'assets/images/splash/onboarding_1.png',
      title: 'Quality',
      description:
          'Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain.',
      backgroundColor: kPrimaryColor,
      textColor: kTextColor,
      dotColor: kTextColor,
    ),
    SplashScreenData(
      imagePath: 'assets/images/splash/onboarding_2.png',
      title: 'Convenient',
      description:
          'Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.',
      backgroundColor: kSecondaryColor,
      textColor: kTextColor,
      dotColor: kTextColor,
    ),
    SplashScreenData(
      imagePath: 'assets/images/splash/onboarding_3.png',
      title: 'Local',
      description:
          'We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time.',
      backgroundColor: kTertiaryColor,
      textColor: kTextColor,
      dotColor: kTextColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: splashData.length,
        itemBuilder: (context, index) {
          return SplashPage(
            data: splashData[index],
            index: index,
            currentPage: _currentPage,
            onNextPressed: () {
              if (_currentPage < splashData.length - 1) {
                _pageController.animateToPage(
                  _currentPage + 1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                // Navigate to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  final SplashScreenData data;
  final int index;
  final int currentPage;
  final VoidCallback onNextPressed;

  SplashPage({
    required this.data,
    required this.index,
    required this.currentPage,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Section with Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                  child: Container(
                    height: screenHeight * 0.5,
                    // Use 50% of the screen height for this section
                    width: double.infinity,
                    color: data.backgroundColor,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: screenHeight * 0.08, // Dynamically position the image
                  child: Transform.scale(
                    scale: index == 0 ? 1.3 : (index == 1 ? 1.17 : 1.21),
                    child: Image.asset(
                      data.imagePath,
                      width: screenWidth * 0.8,
                      // Use 80% of the screen width
                      height: screenHeight * 0.35,
                      // Use 35% of the screen height
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            // Bottom Section with Text and Button
            Expanded(
              child: Container(
                width: double.infinity,
                color: data.backgroundColor,
                child: Material(
                  elevation: 15,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(52),
                    topRight: Radius.circular(52),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // Ensure even spacing
                      children: [
                        // Title
                        Text(
                          data.title,
                          style:
                              kTitleTextStyle.copyWith(color: data.textColor),
                        ),
                        // Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            data.description,
                            textAlign: TextAlign.center,
                            style: kDescriptionTextStyle.copyWith(
                              color: data.textColor,
                            ),
                          ),
                        ),
                        // Pagination Dots
                        PaginationDots(
                          currentPage: currentPage,
                          totalPages: 3,
                          dotColor: data.dotColor,
                        ),
                        // Button
                        PrimaryButton(
                          text: 'Join the movement!',
                          backgroundColor: data.backgroundColor,
                          onPressed: onNextPressed,
                        ),
                        // Login Link
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: data.textColor,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
