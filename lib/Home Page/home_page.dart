import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todos_list_view.dart';
import 'package:todo_app_v2/App State/app_state.dart';
import 'package:todo_app_v2/Todo Actions/add_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Consumer(
      builder: (context, AppState themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: colors.primary,
            backgroundColor: colors.background,
            title: const Text('To Do'),
            titleSpacing: 30,
            actions: [
              IconButton(
                  style: const ButtonStyle(
                      padding:
                          MaterialStatePropertyAll(EdgeInsets.only(right: 30))),
                  onPressed: () => themeNotifier.isDark =
                      themeNotifier.isDark ? false : true,
                  icon: themeNotifier.isDark
                      ? const Icon(Icons.wb_sunny_outlined)
                      : const Icon(Icons.mode_night_outlined))
            ],
          ),
          body: const Todos(),
          floatingActionButton: const AddTodo(),
        );
      },
    );
  }
}
