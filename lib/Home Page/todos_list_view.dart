import 'package:flutter/material.dart';
import 'package:todo_app_v2/Todos/completed_todos.dart';
import '../Todos/active_todos.dart';

class Todos extends StatelessWidget {
  const Todos({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          ActiveTodos(),
          CompletedTodos(),
        ],
      ),
    );
  }
}
