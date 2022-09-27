import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_send_whatsapp/constants.dart';
import 'package:flutter_send_whatsapp/controller/main_controller.dart';
import 'package:flutter_send_whatsapp/screens/m_splash_screen.dart';
import 'package:flutter_send_whatsapp/utils/functions.dart';
import 'package:flutter_send_whatsapp/utils/permission_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

MainController controller = Get.put(MainController());
final Telephony telephony = Telephony.instance;
String? body;
Future initializeService() async {
  try {
    final FlutterBackgroundService service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: mOnStart,
        // auto start service
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: mOnStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  } catch (e) {
    snackBar("", e.toString());
  }
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

void mOnStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    try {
      await controller.checkToShowNotify();
    } catch (e) {
      snackBar("", e.toString());
    }
  });
}

backgrounMessageHandler(SmsMessage msg) async {
  try {
    debugPrint("onBBBBB============");
    debugPrint(msg.date.toString());
    debugPrint("onBBBBB============");
    debugPrint(msg.address.toString());
    debugPrint("onBBBBB============");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    List<String> ids = prefs.getStringList(idMsgsToSendPrfs) ?? [];
    List<String> bodys = prefs.getStringList(bodyMsgsToSendPrfs) ?? [];
    List<String> senders = prefs.getStringList(senderMsgsToSendPrfs) ?? [];
    List<String> searchValueList =
        prefs.getStringList(searchValueListPrefs) ?? [];
    for (String str in searchValueList) {
      if (msg.body.toString().startsWith(str)) {
        debugPrint("yes");
        String id = msg.date.toString();
        String body = msg.body.toString();
        String sender = msg.address.toString();
        debugPrint("----3$id>>> $body>>> $sender");

        ids.add(id);
        bodys.add(body);
        senders.add(sender);
        debugPrint("----4,,, ${ids.length},,, ${bodys.length}");

        await prefs.setStringList(idMsgsToSendPrfs, ids);
        await prefs.setStringList(bodyMsgsToSendPrfs, bodys);
        await prefs.setStringList(senderMsgsToSendPrfs, senders);
        debugPrint("end");
        break;
      } else {
        debugPrint("no");
      }
    }
  } catch (e) {
    debugPrint(e.toString());
    snackBar("", e.toString());
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  await controller.initializeAwesomeNotifications();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  listenToAwesomeNotifications() async {
    AwesomeNotifications().actionStream.listen((action) async {
      try {
        if (action.buttonKeyPressed == "send") {
          await setAfterClickOnNotify();
          await controller.shareMsg(body!);
        }
        // else if (action.buttonKeyPressed == "ignore") {
        //   await setAfterClickOnNotify();
        // }
      } catch (e) {
        debugPrint("-----${e.toString()}");
        snackBar("", e.toString());
      }
    });
  }

  Future setAfterClickOnNotify() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.reload();

      List<String> ids = prefs.getStringList(idMsgsToSendPrfs) ?? [];
      List<String> bodys = prefs.getStringList(bodyMsgsToSendPrfs) ?? [];
      List<String> senders = prefs.getStringList(senderMsgsToSendPrfs) ?? [];

      int id = int.parse(ids[0]);
      body = bodys[0];
      ids.removeAt(0);
      bodys.removeAt(0);
      senders.removeAt(0);
      await prefs.setStringList(idMsgsToSendPrfs, ids);
      await prefs.setStringList(bodyMsgsToSendPrfs, bodys);
      await prefs.setStringList(senderMsgsToSendPrfs, senders);
      await prefs.setInt(smsIdPrfs, id);
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  listenIncomingSms() async {
    try {
      telephony.listenIncomingSms(
        onNewMessage: backgrounMessageHandler,
        onBackgroundMessage: backgrounMessageHandler,
      );
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  @override
  void initState() {
    try {
      requestMultiplePermissions();
      listenToAwesomeNotifications();
      listenIncomingSms();
      super.initState();
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      home: MySplashScreen(),
    );
  }
}
