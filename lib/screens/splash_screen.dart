import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: const Color.fromARGB(255, 87, 220, 102),
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("assets/images/logo(2).png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: HomeScreen(),
    );
  }
}
