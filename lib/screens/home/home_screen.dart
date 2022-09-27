import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/constants.dart';
import 'package:flutter_send_whatsapp/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('الشاشة الرئيسية'),
          actions: <Widget>[
            // TextButton(
            //   child: const Text(
            //     "كلمات البحث",
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            //   onPressed: () async {
            //     try {
            //       goTo(context, const ViewSearchValue());
            //     } catch (e) {
            //       debugPrint(e.toString());
            //     }
            //   },
            // ),
            PopupMenuButton<String>(
              onSelected: (value) {
                return controller.handleClick(context, value);
              },
              itemBuilder: (BuildContext context) {
                return {searchValue, about}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
          ],
        ),
      ),
    );
  }
}
