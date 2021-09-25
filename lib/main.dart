import 'package:flutter/material.dart';
import 'package:local_notification/localNotification.dart';
import 'package:local_notification/notificationInitializer.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    //show the notification
    NotificationPlugin.Initializer();
    NotificationPlugin.ShowOneTimeNotification(DateTime.now());
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask("test_workertask", "test_workertask",
      frequency: Duration(
        minutes: 15,
      ),
      initialDelay: Duration(minutes: 1),
      inputData: {"data1": "value1", "data2": "value2"});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocalNotificationScreen(),
    );
  }
}
