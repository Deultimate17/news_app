import 'package:flutter/material.dart';
import 'package:news_app/models/app_state_manager.dart';
import 'package:news_app/models/news_pages.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: NewsPages.splashPath,
        key: ValueKey(NewsPages.splashPath),
        child: SplashScreen()
    );
  }
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          height: 50,
            image: AssetImage('assets/splash/Frame 222.png'),
        ),
      ),
    );
  }
}
