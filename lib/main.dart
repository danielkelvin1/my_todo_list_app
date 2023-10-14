import 'package:flutter/material.dart';
import 'package:mytodolist/screen/intro_screen.dart';
import 'package:mytodolist/service/notification_service/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await Permission.notification.request().isGranted &&
      await Permission.scheduleExactAlarm.isGranted) {
    await NotificationService.instance.setup();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: const Color(
            0xfff1f5f9,
          ),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const IntroScreen(),
    );
  }
}
