import 'package:flutter/cupertino.dart';
import 'package:flutter_send_whatsapp/constants.dart';
import 'package:flutter_send_whatsapp/screens/home/about_app.dart';
import 'package:flutter_send_whatsapp/screens/settings/search_value/view_search_value.dart';
import 'package:flutter_send_whatsapp/utils/functions.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void handleClick(BuildContext context, String value) {
    switch (value) {
      case searchValue:
        try {
          goTo(context, const ViewSearchValue());
        } catch (e) {
          debugPrint(e.toString());
        }
        break;

      case about:
        try {
          goTo(context, const AboutPage());
        } catch (e) {
          debugPrint(e.toString());
        }
        break;
    }
  }

  @override
  void onInit() async {
    try {
      super.onInit();
    } catch (e) {
      snackBar("", e.toString());
    }
  }
}
