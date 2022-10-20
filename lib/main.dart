import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:habit_tracker_app/views/home_screen/home_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration(seconds: 5)).then((value) {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => HomeScreen()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return SafeArea(
    //   child: Scaffold(
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Image.asset(
    //             "images/logo_habit.png",
    //             width: size.width * 0.75,
    //           ),
    //           SpinKitCubeGrid(
    //             color: Colors.purpleAccent,
    //             size: 50.0,
    //             duration: Duration(seconds: 1),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return SafeArea(
      child: AnimatedSplashScreen(
        splash: Expanded(
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo_habit.png",
                width: size.width * 0.75,
              ),
              SpinKitCubeGrid(
                color: Colors.purpleAccent,
                size: 40.5,
              ),
            ],
          )),
        ),
        nextScreen: const HomeScreen(),
        splashIconSize: size.width,
        duration: 4000,
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
    );
  }
}
