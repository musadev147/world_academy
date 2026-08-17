import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:convert';
// imports removed
import 'dio/dio.dart';
import 'endpoints.dart';
import '../common_wigdets/app_toast.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("====== [DAMLOOK APP] FCM BACKGROUND HANDLER STARTED ======");
  print("Message ID: ${message.messageId}");
  print("Notification Data: ${message.data}");
  print("Notification Payload present: ${message.notification != null}");
  if (message.notification != null) {
    print("Notification Title: ${message.notification?.title}");
    print("Notification Body: ${message.notification?.body}");
  }
  
  final _localNotifications = FlutterLocalNotificationsPlugin();
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings();
  const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
  await _localNotifications.initialize(settings: settings);

  String? title = message.notification?.title ?? message.data['title'] ?? message.data['title_'] ?? "New Message";
  String? body = message.notification?.body ?? message.data['body'] ?? message.data['message'] ?? message.data['body_'] ?? "";

  // Only show local notification if it's a data-only message to prevent duplicate notifications
  if (message.notification == null) {
    print("This is a data-only message. Showing custom local notification...");
    await _localNotifications.show(
      id: message.hashCode,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription: 'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: json.encode(message.data),
    );
    print("Local notification displayed successfully.");
  } else {
    print("This message has a notification payload. The OS should show it automatically.");
  }
  print("====== [DAMLOOK APP] FCM BACKGROUND HANDLER END ======");
}

class FirebaseApi {
  static final FirebaseApi _instance = FirebaseApi._internal();
  factory FirebaseApi() => _instance;
  FirebaseApi._internal();

  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    // Request permission from user (will prompt on iOS/Web)
    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await initLocalNotifications();
      // Initialize further settings for push notification
      initPushNotifications();
    }
  }

  Future<void> sendTokenToServer() async {
    print("====== [DAMLOOK APP] GENERATING FCM TOKEN ======");
    try {
      final fCMToken = await _firebaseMessaging.getToken();
      if (fCMToken != null) {
        print("SUCCESS! FCM Token Generated: $fCMToken");
        print("Sending token to backend...");
        final deviceType = Platform.isIOS ? 'ios' : 'android';
        try {
          await postHttp(Endpoints.fcmToken(), {
            "fcm_token": fCMToken,
            "device_type": deviceType,
          });
          if (kDebugMode) {
            print('Successfully sent FCM token to backend');
          }
        } catch (apiError) {
          if (kDebugMode) {
            print('Failed to send FCM token to backend: $apiError');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get FCM token: $e');
      }
    }
  }

  Future<void> initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          _handleNotificationRouting(response.payload!);
        }
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      ),
    );
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    
    // Add a small delay to ensure GetMaterialApp is fully initialized when app is opened from terminated state
    Future.delayed(const Duration(milliseconds: 1500), () {
      _handleNotificationRouting(json.encode(message.data), messageData: message.data);
    });
  }

  void _handleNotificationRouting(String payload, {Map<String, dynamic>? messageData}) {
    // Basic routing logic for World Academy
    Get.offAllNamed('/student_dashboard');
  }

  Future<void> initPushNotifications() async {
    // Set presentation options for iOS foreground notifications
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle message when app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Attach event listeners for when a notification opens the app from background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Handle messages in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("====== [DAMLOOK APP] FCM FOREGROUND MESSAGE RECEIVED ======");
      print("Message ID: ${message.messageId}");
      print("Notification Data: ${message.data}");
      print("Notification Payload present: ${message.notification != null}");
      if (message.notification != null) {
        print("Notification Title: ${message.notification?.title}");
        print("Notification Body: ${message.notification?.body}");
      }
      String? title = message.notification?.title ?? message.data['title'] ?? message.data['title_'] ?? "New Message";
      String? body = message.notification?.body ?? message.data['body'] ?? message.data['message'] ?? message.data['body_'] ?? "";

      _localNotifications.show(
        id: message.hashCode,
        title: title,
        body: body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: json.encode(message.data),
      );
    });
  }
}
