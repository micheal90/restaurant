// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/shared/local/constants.dart';

class Messaging {
  static late FirebaseMessaging messaging;
  static init() {
    messaging = FirebaseMessaging.instance;
  }

  static void pushFCMtoken() async {
    token = await messaging.getToken();
    debugPrint(token);
  }

  static int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  static requestingNotificationPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        Get.defaultDialog(
          title: 'Allow Notifications',
          content: const Text('Our app would like to send you notifications'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Don\'t Allow',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () => AwesomeNotifications()
                  .requestPermissionToSendNotifications()
                  .then((_) => Get.back()),
              child: const Text(
                'Allow',
                style: TextStyle(
                  color: KprimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      }
    });
  }

  static Future<void> createNotification(String? title, String? body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'basic_channel',
          title: title,
          body: body,
          wakeUpScreen: true,
          displayOnBackground: true,
          displayOnForeground: true,
          autoDismissible: true,
          customSound: 'resource://raw/notification'
          //bigPicture: 'asset://assets/chickenalt.png',
          //notificationLayout: NotificationLayout.Default,
          ),
      // actionButtons: [NotificationActionButton(key: 'open', label: 'Open')],
    );
  }
}
