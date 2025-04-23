import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/login_page.dart';

void main() async {
  // Asegurarse de que Flutter esté inicializado antes de usar cualquier plugin
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IGRU - Universidad Popular del Cesar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1B8E3D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF1B8E3D),
          primary: Color(0xFF1B8E3D),
        ),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
