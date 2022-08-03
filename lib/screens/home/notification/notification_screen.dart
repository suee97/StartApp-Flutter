import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:start_app/utils/common.dart';
import '../../../models/push_notification.dart';

/// not yet

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   late int _totalNotifications;
//   late final FirebaseMessaging _messaging;
//   PushNotification? _notificationInfo;
//
//   Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     print("Handling a background message: ${message.messageId}");
//   }
//
//   void requestAndRegisterNotification() async {
//     await Firebase.initializeApp();
//
//     _messaging = FirebaseMessaging.instance;
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     NotificationSettings settings = await _messaging.requestPermission(
//         alert: true, badge: true, provisional: false, sound: true);
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("User granted premission");
//       String? token = await _messaging.getToken();
//       print("The token is ${token!}");
//
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         PushNotification notification = PushNotification(
//             title: message.notification?.title,
//             body: message.notification?.body);
//
//         setState(() {
//           _notificationInfo = notification;
//           _totalNotifications++;
//         });
//
//         if (_notificationInfo != null) {
//           showSimpleNotification(Text(_notificationInfo!.title!),
//               leading:
//                   NotificationBadge(totalNotifications: _totalNotifications),
//               subtitle: Text(_notificationInfo!.body!),
//               background: Colors.cyan.shade700,
//               duration: Duration(seconds: 2));
//         }
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     requestAndRegisterNotification();
//     _totalNotifications = 0;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("notification screen"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "App for capturing Firebase Push Notification",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             NotificationBadge(totalNotifications: _totalNotifications),
//             SizedBox(
//               height: 16,
//             ),
//             _notificationInfo != null
//                 ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "TITLE: ${_notificationInfo!.title}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Text(
//                         "BODY: ${_notificationInfo!.body}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       )
//                     ],
//                   )
//                 : Container(),
//           ],
//         ));
//   }
// }
