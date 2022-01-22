// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/helper/app_bindings.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/shared/network/sevices/cash_helper.dart';
import 'package:resturant_app/shared/network/sevices/dio_helper.dart';
import 'package:resturant_app/shared/network/sevices/messaging.dart';
import 'package:resturant_app/views/control_veiw.dart';
import 'package:resturant_app/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Messaging.init();
  Messaging.pushFCMtoken();
  AwesomeNotifications().initialize('resource://drawable/launcher_icon', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      defaultColor: KprimaryColor,
      importance: NotificationImportance.High,
      channelShowBadge: true,
      channelDescription: '',
    ),
  ]);
  await CashHelper.init();
  //CashHelper.clearKey(key: 'userOrder');
  await DioHelper.init();
  Get.put(AuthController());
  Get.put(OrdersController());
  FirebaseMessaging.onMessage.listen((message) {
    debugPrint('Got a message');
    debugPrint('Message data: ${message.data}');
    debugPrint(message.notification?.title);
    if (message.notification != null) {
      Messaging.createNotification(
          message.notification?.title, message.notification?.body);
    }
    // AwesomeNotifications().createNotificationFromJsonData(message.data);
  });

  AwesomeNotifications().actionStream.listen((notification) {
    if (notification.channelKey == 'basic_channel') {
      AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1),
          );
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return GetMaterialApp(
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Resturant App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: KprimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: KbackGroundColor,
      ),
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 7)),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const SplashScreens()
                : ControlView(),
      ),
    );
  }
}
