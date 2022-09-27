import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/constants.dart';
import 'package:flutter_send_whatsapp/controller/home_controller.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text('حول التطبيق'),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", width: 200),
                  const SizedBox(height: 10),
                  const Text(
                    "Share Sms",
                    style: TextStyle(fontSize: 35),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "النسخة: 1.0.0",
                    style: TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    "برمجة و تصميم: م. عبد الإله الخليدي",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
