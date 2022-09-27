import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/constants.dart';
import 'package:flutter_send_whatsapp/utils/functions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  int updateIndex = 0;
  String updateBody = "";

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController searchValueController = TextEditingController();
  List<String> searchVluesList = [];

  Future getAllSearchValues() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      searchVluesList = prefs.getStringList(searchValueListPrefs) ?? [];
      update();
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  bool isFoundVar = false;
  isFound(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    List<String> searchVluesList =
        prefs.getStringList(searchValueListPrefs) ?? [];
    if (searchVluesList.contains(value)) {
      isFoundVar = true;
    } else {
      isFoundVar = false;
    }
  }

  Future addSearchValue() async {
    try {
      if (key.currentState!.validate()) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.reload();
        searchVluesList = prefs.getStringList(searchValueListPrefs) ?? [];
        searchVluesList.add(searchValueController.text);
        await prefs.setStringList(searchValueListPrefs, searchVluesList);
        Get.back();
        update();
        snackBar("", "تمت العملية بنجاح");
      }
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  Future saveSearchValue() async {
    try {
      if (key.currentState!.validate()) {
        searchVluesList[updateIndex] = searchValueController.text;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setStringList(searchValueListPrefs, searchVluesList);
        Get.back();
        update();
        snackBar("", "تمت العملية بنجاح");
      }
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  Future<bool?> showConfirmationDialog(BuildContext context, int index) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('هل أنت متأكد من العملية؟'),
          actions: <Widget>[
            TextButton(
              child: const Text('نعم'),
              onPressed: () {
                removeFromList(index);
                Navigator.pop(context, true); // showDialog() returns true
              },
            ),
            TextButton(
              child: const Text('لا'),
              onPressed: () {
                // update();
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }

  removeFromList(int index) async {
    try {
      searchVluesList.removeAt(index);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(searchValueListPrefs, searchVluesList);
      update();
      snackBar("", "تمت العملية بنجاح");
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  @override
  void onInit() async {
    try {
      getAllSearchValues();
      super.onInit();
    } catch (e) {
      snackBar("", e.toString());
    }
  }
}
