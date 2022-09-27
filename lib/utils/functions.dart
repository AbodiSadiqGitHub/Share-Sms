import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/widgets/custom_page_route.dart';
import 'package:get/get.dart';

void snackBar(String title, String body) {
  Get.rawSnackbar(
      messageText: Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          body,
          style: const TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ));
}

void goTo(BuildContext context, Widget child) {
  Navigator.push(
    context,
    CustomPageRoute(chid: child),
  );
}
