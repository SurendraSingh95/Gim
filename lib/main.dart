import 'dart:developer';

import 'package:fitness/Controllers/HomeController/change_themes_controller.dart';
import 'package:fitness/custom/app_thems.dart';
import 'package:fitness/provider/PushNotificationService.dart';
import 'package:fitness/utils/Demo_Localization.dart';
import 'package:fitness/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Network Connectivity/connectivty_check.dart';

import 'SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBLe9NT-gWIlDgZ6AqsMFSwRty9oKcnUQw',
      appId: '1:1065267522684:android:19705631d2754bf58fadf9',
      projectId: 'fitness-ce18f',
      messagingSenderId: '1065267522684',
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  PushNotificationService pushNotificationService = PushNotificationService();
  await pushNotificationService.initialize();

  NetworkConnectivityService();
  await SharedPref.getInstance();
  SharedPref.setLanguageToPrefs('ar');

  Get.put(ThemeController());

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    debugPrint("state change --> $state");
    state.changeLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = const   Locale('en', 'US');
  }

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
      debugPrint("locale change --> $_locale");
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      locale: _locale,
      localizationsDelegates: const [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'KW'),
        Locale('en', 'US'),
      ],
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
    // home: const SelectTrainerScreen(),
     home: const SplashScreen(),
    );
  }
}
