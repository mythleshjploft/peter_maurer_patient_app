import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peter_maurer_patients_app/app/services/utils/get_storage.dart';
import 'package:peter_maurer_patients_app/app/services/utils/storage_keys.dart';

String fcmToken = '';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (Platform.isIOS) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDW2PBJshaoyPxWTY988fM9tpriLAYEECE',
        appId: '1:467194117630:android:f0b9fce6feba6726f954af',
        messagingSenderId: '467194117630',
        projectId: 'mkg-maurer',
      ),
    );
  }

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

Future<void> getFcmToken() async {
  try {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "FcmToken";
    BaseStorage.write(StorageKeys.fcmToken, fcmToken);
    log('FireBase FCM token=> $fcmToken');
  } catch (e) {
    if (kDebugMode) {
      print("FireBase FCM toke exception====> $e");
    }
  }

  // BaseStorage.write(StorageKeys.fcmToken, fcmToken);
}

void initMessaging() async {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingIos = const DarwinInitializationSettings(
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingIos);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
    String notificationTitle = remoteMessage.notification?.title ?? "";
    String notificationBody = remoteMessage.notification?.body ?? "";
    // if (Platform.isAndroid) {
    showNotification(notificationTitle, notificationBody);
    // }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // FlutterAppBadger.removeBadge();
    // if (spUtil?.getString(Preferences.user_token) != "") {
    //   apiHandler?.userProfile();
    // }
    //  if (message.notification != null) {

    //  }
    if (kDebugMode) {
      print("A new onMessageOpenedApp event was published!");
    }
    // Map<String,dynamic> notificationData = message.data;
    // final notificationType = json.decode(message.data["notification_type"]);
    final data = json.decode(message.data["data"]);

    sleep(const Duration(milliseconds: 500));
    // eventBus?.fire([notificationType, data]);
    if (kDebugMode) {
      print(data);
    }
    // handleClick(notificationData);
  });
  return null;
}

void showNotification(String title, String body) async {
  var androidChannel = const AndroidNotificationChannel(
    'pushnotificationapp',
    'pushnotificationapp',
    description: 'Channel Description',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);

  var notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: androidChannel.description,
      importance: Importance.high,
      priority: Priority.high,
    ),
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
    payload: 'payload',
  );
}
