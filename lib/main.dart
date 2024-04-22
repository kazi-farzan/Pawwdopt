import 'package:flutter/material.dart';
import 'package:doggie_shop/screens/cart_screen.dart';
import 'package:doggie_shop/screens/history_screen.dart';
import 'package:doggie_shop/screens/home_screen.dart';
import 'package:doggie_shop/utilities/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog App',
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFFf5f5f5),
        scaffoldBackgroundColor: const Color(0xFFf5f5f5),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFff4c68),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.elliptical(25, 25),
                  right: Radius.elliptical(25, 25)),
            ),// Use custom shape for AppBar
          titleTextStyle: TextStyle(color: const Color(0xFFffffff), fontSize: 30.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF23272b)), // Set your desired background color
            textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)), // Set your desired text color
            // Add more customizations as needed
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/history': (context) => HistoryScreen(),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}
