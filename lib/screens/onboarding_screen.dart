import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/app_state_manager.dart';
import 'package:news_app/models/news_pages.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: NewsPages.onBoardingPath,
        key: ValueKey(NewsPages.onBoardingPath),
        child: const OnboardingScreen()
    );
  }
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Getting Started',
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.chevron_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Expanded(child: buildPages()),
              buildIndicator(),
              buildActionButtons(),
            ],
          )
      ),
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          child: const Text('Skip'),
            onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .completeOnboarding();
            })
      ],
    );
  }
  
  Widget buildPages() {
    return PageView(
      controller: controller,
      children: [
        onboardPageView(
            const AssetImage('assets/splash/Illustration.png'),
            'Explore thousands of latest news'
        ),
        onboardPageView(
            const AssetImage('assets/splash/Illustration (1).png'),
            'Find news with better filters'
        ),
        onboardPageView(
            const AssetImage('assets/splash/Illustration (2).png'),
            'Bookmark, share & comments on news'
        ),
      ],
    );
  }

  Widget onboardPageView(ImageProvider imageProvider, String text) {
    return Padding(
        padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Image(
                fit: BoxFit.fitWidth,
                  image: imageProvider,
              )),
          const SizedBox(
            height: 16,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20.0
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height:16),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
        controller: controller,
        count: 3,
      effect: const WormEffect(
        activeDotColor: Colors.blueAccent,
      ),
    );
  }
}
