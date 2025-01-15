
import 'dart:developer';
import 'dart:math' hide log;

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService() {
    _initialize();
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void _initialize() async {
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings());

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,

    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.instance.getInitialMessage().then(
            (message) {
          log("FirebaseMessaging.instance.getInitialMessage");
          if (message != null) {
            log("New Notification");
          }
        },
      );
      FirebaseMessaging.onMessage.listen(
            (message) {
          log("FirebaseMessaging.onMessage");
          if (message.notification != null) {
            log('title : ${message.notification!.title}');
            log('body : ${message.notification!.body}');
            log("message.data ${message.data}");
            display(message);
          }
        },
      );

      FirebaseMessaging.onMessageOpenedApp.listen(
            (message) {
          log("FirebaseMessaging.onMessageOpenedApp");
          if (message.notification != null) {
            log('title : ${message.notification?.title}');
            log('body : ${message.notification!.body}');
            log("message.data ${message.data}");
          }
        },
      );
    }
  }

  Future<void> handleNotification(Map<String, dynamic> message) async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      // TODO: handle the notification
    } else {

    }
  }

  void display(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(1000);

      const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        "Fit_channel_id",
        "Fitness",
        channelDescription: "Channel for Fit notifications",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        styleInformation: BigTextStyleInformation(''),
      );

      const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
          iOS: DarwinNotificationDetails(presentAlert: true));


      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } catch (e) {
      log('Error>>>$e');
    }
  }

}

