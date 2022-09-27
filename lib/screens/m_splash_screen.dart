import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/constants.dart';
import 'package:flutter_send_whatsapp/screens/home/home_screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/logo.png', width: 250),
      title: const Text(
        appName,
        style: TextStyle(
          color: Color.fromARGB(255, 233, 241, 240),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue.shade400,
      showLoader: false,
      loadingText: const Text(
        "النسخة: 1.0.0",
        style: TextStyle(
          color: Color.fromARGB(255, 71, 77, 76),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      navigator: const HomePage(),
      durationInSeconds: 2,
    );
  }
}
