import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/constants.dart';
import 'package:flutter_send_whatsapp/utils/functions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class MainController extends GetxController {
  String contactName = "";

  Future getContactNameFromNumber(String phoneNumber) async {
    try {
      if (await FlutterContacts.requestPermission()) {
        final contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);

        Contact contact = contacts.firstWhere(
            (c) => c.phones.any(
                (a) => a.number.compareTo(phoneNumber) == 0 ? true : false),
            orElse: () => Contact());
        if (contact.displayName.isNotEmpty) {
          contactName = contact.displayName;
        } else {
          contactName = phoneNumber;
        }
      }
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  Future checkToShowNotify() async {
    try {
      debugPrint("=========1========");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      int lastSmsId = prefs.getInt(smsIdPrfs) ?? -1;
      debugPrint(lastSmsId.toString());
      List<String> msgsList = prefs.getStringList(idMsgsToSendPrfs) ?? [];
      debugPrint("===>>${msgsList.length}");
      if (msgsList.isEmpty) {
        AwesomeNotifications().dismissAllNotifications();
      }
      for (int i = 0; i < msgsList.length; i++) {
        debugPrint("...1${msgsList[i]}");

        int id = int.parse(msgsList[i]);
        debugPrint("...$id");
        if (id > lastSmsId) {
          String body = (prefs.getStringList(bodyMsgsToSendPrfs) ?? [])[i];
          String sender = (prefs.getStringList(senderMsgsToSendPrfs) ?? [])[i];
          await showNotificationWithButton(body, sender);
          break;
        } else {
          debugPrint("$id Not Greater than $lastSmsId");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      snackBar("", e.toString());
    }
  }

  shareMsg(String msg) async {
    try {
      await Share.share(msg);
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  Future initializeAwesomeNotifications() async {
    try {
      AwesomeNotifications().initialize(
          // set the icon to null if you want to use the default app icon
          'resource://drawable/ic_launcher',
          [
            NotificationChannel(
                channelGroupKey: 'basic_channel_group',
                channelKey: 'basic_channel',
                channelName: 'Basic notifications',
                channelDescription: 'Notification channel for basic tests',
                defaultColor: const Color(0xFF9D50DD),
                ledColor: Colors.white)
          ],
          // Channel groups are only visual and are not required
          channelGroups: [
            NotificationChannelGroup(
                channelGroupkey: 'basic_channel_group',
                channelGroupName: 'Basic group')
          ],
          debug: true);
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  Future showNotificationWithButton(String body, String id) async {
    try {
      await getContactNameFromNumber(id);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: contactName,
          body: body,
        ),
        actionButtons: <NotificationActionButton>[
          NotificationActionButton(key: 'send', label: 'مشاركة'),
          // NotificationActionButton(key: 'ignore', label: 'تجاهل'),
        ],
      );
    } catch (e) {
      snackBar("", e.toString());
    }
  }

  @override
  void onInit() async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.clear();
      super.onInit();
    } catch (e) {
      snackBar("", e.toString());
    }
  }
}
