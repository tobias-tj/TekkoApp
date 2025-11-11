import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:tekko/app_routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FirebaseMessageService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint("📩 Notificación recibida en background: ${message.messageId}");
  }

  static Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          debugPrint("🔗 Notificación presionada con payload: $payload");
          appRouter.goNamed(payload);
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = notification?.android;

      if (notification != null && android != null) {
        _localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'tekko_channel',
              'Tekko Notifications',
              channelDescription: 'Canal para notificaciones de Tekko',
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
            ),
          ),
          payload: message.data['payload'],
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final payload = message.data['payload'];
      if (payload != null && payload.isNotEmpty) {
        debugPrint("🔗 Notificación presionada con payload: $payload");
        appRouter.goNamed(payload);
      }
    });

    final token = await _firebaseMessaging.getToken();
    debugPrint("📱 Token FCM del dispositivo: $token");
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _localNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'tekko_channel',
          'Tekko Notifications',
          channelDescription: 'Canal para notificaciones de Tekko',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      payload: payload,
    );
  }
}
