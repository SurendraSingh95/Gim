import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission for notifications (especially on iOS)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }

    // Initialize local notifications for foreground messages
    _initializeLocalNotifications();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        showNotification(notification);
      }
    });

    // Handle background and terminated notification clicks
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // When the notification is clicked, navigate to the home screen
      _handleNotificationClick(message);
    });

    // Handle notification if the app is opened from a terminated state
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      // When the app is launched by tapping the notification
      _handleNotificationClick(initialMessage);
    }
  }
  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null) {
          _handleNotificationPayload(notificationResponse.payload!);
        }
      },
    );
  }

  Future<void> showNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: 'home', // You can pass a payload to determine which screen to navigate to
    );
  }

  // Navigate to the home screen or other screens based on the notification
  void _handleNotificationClick(RemoteMessage message) {
    // Example of using GetX for navigation
    print("object========YYYYYYYYYYYYYYYYYYY");
    // Get.toNamed('/home');
    // Get.toNamed('/home'); // Replace '/home' with your actual home screen route
    // GetPage(name: '/home', page: () => HomeScreen());
  }

  // Handle notification payload when tapped
  void _handleNotificationPayload(String payload) {
    // print("object======== getYYYYYYYYYYYYYYYYYYY");
    if (payload == 'home') {
      // print("object======== getHHHHH");
      // Navigate to home screen
      // Get.toNamed('/home');
      // GetPage(name: '/home', page: () => HomeScreen());
    }
    // Add other payload handling if necessary
  }
}
