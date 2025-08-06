import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jido Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFFF1493), // Fuchsia
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFFF1493), // Fuchsia
          secondary: const Color(0xFF00FF00), // Neon Green
          surface: Colors.grey[900]!,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Color(0xFFFF1493), fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Color(0xFF00FF00), fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
