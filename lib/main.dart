import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_state.dart';
import 'add_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Tasks',
        theme: _buildTheme(Brightness.dark),
        home: const HomePage(),
      ),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    canvasColor: Colors.transparent,
    shadowColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 0, 94, 255),
        brightness: Brightness.dark),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    var appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
          foregroundColor: colors.primary,
          backgroundColor: appState.currentTheme,
          title: const Text('ToDo'),
          leading: const Icon(Icons.toll_outlined)),
      body: const HomePage(),
      floatingActionButton: const AddTodo(),
    );
  }
}
