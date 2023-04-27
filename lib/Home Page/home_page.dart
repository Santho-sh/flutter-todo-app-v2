import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'todos_list_view.dart';
import 'package:todo_app_v2/App State/app_state.dart';
import 'package:todo_app_v2/Todo Actions/add_todo.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Consumer<AppState>(
      builder: (context, themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: colors.primary,
            backgroundColor: colors.background,
            title: const Text('To Do'),
            titleSpacing: 30,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: DayNightSwitcherIcon(
                  dayBackgroundColor: colors.primaryContainer,
                  isDarkModeEnabled: themeNotifier.isDark,
                  onStateChanged: (isDarkModeEnabled) {
                    themeNotifier.isDark = isDarkModeEnabled;
                  },
                ),
              ),
            ],
          ),
          body: const Todos(),
          floatingActionButton: const AddTodo(),
        );
      },
    );
  }
}
