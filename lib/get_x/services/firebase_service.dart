import 'package:explore_places/get_x/core/utils/notification_utils.dart';
import 'package:explore_places/get_x/data_sources/local/cache_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FirebaseService with CacheManager {
  static Future<void> initFirebase() async {
    final CacheManager cacheManager = Get.find<CacheManager>();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    Logger logger = Logger();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getToken().then((String? token) async {
      assert(token != null);
      print("Push Messaging token: $token");
      try {
         cacheManager.setData(CacheManagerKey.firebaseToken, token);
        print(
            "Device Token Saved: ${cacheManager.getString(CacheManagerKey.firebaseToken)}");
      } catch (_) {
        print("Push Messaging token error $_");
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) => {
      if (message != null)
        {
          cacheManager.setData(CacheManagerKey.notificationTitle,
              message.notification?.title),
          cacheManager.setData(CacheManagerKey.notificationDescription,
              message.notification?.body),
          logger.i(
              "Message Data : ${message.notification?.title ?? "Hello Friday"} and ${message.notification?.body ?? "Happy Happy"} are coming from Terminated State")
        }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      logger.i("Message Data In App : ${message.notification!.title!}");
      NotificationUtils.initLocalNotification(message);
      NotificationUtils.showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i("Message Data : ${message.notification!.title!}");
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}
}
