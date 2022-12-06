import 'dart:async';

import 'package:etiqa_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Etiqa',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Splash Screen State
  _SplashScreenState() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        //Route to Home Page
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 2000),
              pageBuilder: (_, __, ___) => const MyHomePage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SizedBox(
            child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                //Color gradient
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: const Alignment(5.0, 1.0),
                    colors: [Colors.amberAccent.shade700, Colors.white]),
              ),
            ),
            SafeArea(
              child: Center(
                //Fade transition
                child: FadeTransition(
                  opacity: animation,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: 150,
                    height: 150,
                    //Image
                    child: Hero(
                        tag: "logo",
                        child: Image.asset("assets/etiqa-logo.png")),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
