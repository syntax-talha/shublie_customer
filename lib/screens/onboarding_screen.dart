import 'package:flutter/material.dart';
import 'package:shublie_customer/components/x_button.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                _buildPage(
                  title: 'Welcome to Shublie',
                  description: 'Find the best services for your needs.',
                  imagePath: 'assets/onboarding1.jpg',
                ),
                _buildPage(
                  title: 'Seamless Experience',
                  description:
                      'Enjoy an effortless experience with top-notch vendors.',
                  imagePath: 'assets/onboarding2.jpg',
                ),
                _buildPage(
                  title: 'Track Your Orders',
                  description:
                      'Stay updated with real-time tracking of your services.',
                  imagePath: 'assets/onboarding3.jpg',
                ),
              ],
            ),
          ),
          _buildIndicators(),
          SizedBox(height: 16.0),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String title,
      required String description,
      required String imagePath}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(imagePath, width: 250, height: 250),
        SizedBox(height: 24.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: _currentPage == index ? 12.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage == 2
              ? SizedBox.shrink()
              : XButton(
                  text: 'Skip',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
          _currentPage == 2
              ? XButton(
                  text: 'Get Started',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                )
              : XButton(
                  text: 'Next',
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
        ],
      ),
    );
  }
}
