import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // local notification
  var androidInitializationSettings = AndroidInitializationSettings('app_icon');
  var iosInitializationSettings = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: androidInitializationSettings, iOS: iosInitializationSettings);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Detroit'));

  showNotificationSchedule();
  runApp(MyApp());
}

Future showNotificationSchedule() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name', 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}

Future showNotification() async {
  var androidPlatformChannelSpesifics = AndroidNotificationDetails(
      'notification_channel_id', 'Channel Name', 'Description',
      importance: Importance.max, priority: Priority.high);

  var iOSPlatformChannelSpesifics = IOSNotificationDetails();

  var platformChannelSpesifics = NotificationDetails(
      android: androidPlatformChannelSpesifics,
      iOS: iOSPlatformChannelSpesifics);

  flutterLocalNotificationsPlugin.show(
      0, 'Bildirim Başlık', "Bildirim İçerik", platformChannelSpesifics,
      payload: 'Default_Sound');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Text("notif"),
        ),
      ),
    );
  }
}
