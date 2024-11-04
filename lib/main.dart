import 'package:flutter/material.dart';
import 'package:news_app/models/app_state_manager.dart';

import 'package:provider/provider.dart';
import 'navigation/app_router.dart';

void main() {

  runApp(

      const NewsApp());
}

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;
  @override
  void initState() {
   _appRouter = AppRouter(appStateManager: _appStateManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => _appStateManager)
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Router(routerDelegate: _appRouter),
      ),
    );
  }
}
