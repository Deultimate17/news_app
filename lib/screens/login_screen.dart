import 'package:flutter/material.dart';
import 'package:news_app/models/app_state_manager.dart';
import 'package:news_app/models/news_pages.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: NewsPages.loginPath,
        key: ValueKey(NewsPages.loginPath),
        child: const LoginScreen()
    );
  }
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Image(
                  height: 50,
                  image: AssetImage('assets/splash/Frame 222.png'),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    height: 0.5,
                  )

              )
              ),
              const SizedBox(
                height: 16.0,
              ),
              const TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        height: 0.5,
                      )

                  )
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.blueAccent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                  Provider.of<AppStateManager>(context, listen: false)
                      .login('mockUsername', 'mockPassword');
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
