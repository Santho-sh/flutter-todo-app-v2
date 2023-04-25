import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';
import 'dismissible_todo.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    if (appState.completedTodos.isEmpty) {
      return const SizedBox.shrink();
    }

    return ExpansionTile(
      onExpansionChanged: (_) {
        HapticFeedback.lightImpact();
      },
      controlAffinity: ListTileControlAffinity.leading,
      childrenPadding: const EdgeInsets.only(left: 8, right: 8),
      title: const Text("Completed"),
      children: <Widget>[
        for (var todo in appState.completedTodos)
          if (todo.isImportant) DismissibleTodo(todo: todo),
        for (var todo in appState.completedTodos)
          if (!todo.isImportant) DismissibleTodo(todo: todo),
      ],
    );
  }
}
