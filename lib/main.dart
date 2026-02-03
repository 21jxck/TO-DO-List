import 'package:flutter/material.dart';
import 'UIComponents/MainScreen.dart';
import 'models/TodoManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final manager = TodoManager();
  await manager.initialize();

  runApp(MyApp(manager: manager));
}

class MyApp extends StatelessWidget {
  final TodoManager manager;  // ← Aggiungi final

  const MyApp({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minecraft TODO List',
      theme: ThemeData(
        primaryColor: const Color(0xFF8B4513),
        scaffoldBackgroundColor: const Color(0xFF7CB342),
        fontFamily: 'Courier',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B4513),
          brightness: Brightness.light,
        ),
      ),
      home: MainScreen(manager: manager),
    );
  }
}