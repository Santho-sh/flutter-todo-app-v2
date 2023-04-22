import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/Todo%20Actions/delete_todo.dart';
import '../App State/app_state.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    if (appState.completedTodos.isEmpty) {
      return const SizedBox.shrink();
    }

    return ExpansionTile(
      title: const Text("Completed"),
      children: <Widget>[
        for (var activeTodo in appState.completedTodos)
          ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: const Color.fromARGB(255, 26, 26, 26),
            key: UniqueKey(),
            leading: const Icon(Icons.adjust),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    activeTodo,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                DeleteTodo(todo: activeTodo),
              ],
            ),
          ),
      ],
    );
  }
}
