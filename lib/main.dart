import 'package:autentocacao/screens/home_screen.dart';
import 'package:autentocacao/screens/login_screen.dart';
import 'package:autentocacao/screens/register_screen.dart';
import 'package:autentocacao/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    isAuthenticated = authService.user != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho AS',
      debugShowCheckedModeBanner: false,
      initialRoute: isAuthenticated ? "/home" : "/",
      routes: {
        "/": (context) => LoginScreen(authService: authService),
        "/register": (context) => RegisterScreen(authService: authService),
        "/home": (context) => HomeScreen(
          authService: authService,
          title: 'Lista de Países',
        ),
      },
    );
  }
}
