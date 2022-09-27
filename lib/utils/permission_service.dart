import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/utils/functions.dart';
import 'package:permission_handler/permission_handler.dart';

requestMultiplePermissions() async {
  try {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.contacts,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.sms]!.isDenied) {
      //check each permission status after.
      debugPrint("Permission is denied.");
      // snackBar("", "Permission is denied.");
    }

    if (statuses[Permission.contacts]!.isDenied) {
      //check each permission status after.
      debugPrint("Permission is denied.");
      // snackBar("", "Permission is denied.");
    }
  } catch (e) {
    snackBar("", e.toString());
  }
}
