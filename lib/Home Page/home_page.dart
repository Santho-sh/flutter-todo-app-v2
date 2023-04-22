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
    var appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: colors.primary,
        backgroundColor: appState.currentTheme,
        title: const Text('To Do'),
        leading: const Icon(Icons.toll_outlined),
      ),
      body: const Todos(),
      floatingActionButton: const AddTodo(),
    );
  }
}
