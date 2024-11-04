import 'package:flutter/material.dart';
import 'package:news_app/models/app_state_manager.dart';
import 'package:news_app/models/news_pages.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/onboarding_screen.dart';
import 'package:news_app/screens/splash_screen.dart';

class AppRouter extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;

  AppRouter({ required this.appStateManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete) OnboardingScreen.page(),
        if (appStateManager.isOnboardingComplete) HomePage.page()
      ],
    );
  }

  bool _handlePopPage (
      Route<dynamic> route,
      result
      ) {
    if (!route.didPop(result)) {
      return false;
    }
    if (route.settings.name  == NewsPages.onBoardingPath) {
      appStateManager.logout();
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async => null;
}