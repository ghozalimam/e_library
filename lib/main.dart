import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/registration_screen.dart';
import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/providers/favorites_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: eLibraryApp(),
    ),
  );
}

class eLibraryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/registration': (context) => RegistrationScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => HomeScreen());
      },
    );
  }
}
