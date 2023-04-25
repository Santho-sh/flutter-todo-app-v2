import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/Todos/completed_todos.dart';
import '../App State/app_state.dart';
import '../Todos/active_todos.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Todos extends StatelessWidget {
  const Todos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    // If todo lists is empty
    if (appState.activeTodos.isEmpty &&
        appState.completedTodos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/empty_list.svg",
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "No Tasks",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    }

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
