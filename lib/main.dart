import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'App State/app_state.dart';
import 'Home Page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: Consumer(
        builder: (context, AppState themeModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tasks',
            theme: themeModel.isDark
                ? _buildTheme(Brightness.dark)
                : _buildTheme(Brightness.light),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  if (brightness == Brightness.dark) {
    return baseTheme.copyWith(
      scaffoldBackgroundColor: Colors.black,
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          secondary: const Color.fromARGB(255, 26, 26, 26),
          onSecondary: Colors.white,
          background: Colors.black,
          seedColor: const Color.fromARGB(255, 0, 94, 255),
          brightness: Brightness.dark),
    );
  } else {
    return baseTheme.copyWith(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          secondary: const Color.fromARGB(255, 232, 231, 231),
          onSecondary: Colors.black,
          background: Colors.white,
          seedColor: const Color.fromARGB(255, 0, 94, 255),
          brightness: Brightness.light),
    );
  }
}
