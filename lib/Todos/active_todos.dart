import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';
import 'dismissible_todo.dart';

class ActiveTodos extends StatelessWidget {
  const ActiveTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

    if (appState.activeStaredTodos.isEmpty &&
        appState.activeUnstaredTodos.isEmpty) {
      return const SizedBox.shrink();
    }

    return ReorderableListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 8, right: 8),
      onReorder: (oldIndex, newIndex) =>
          appState.changeIndex(oldIndex, newIndex),
      children: [
        for (var todo in appState.activeStaredTodos)
          DismissibleTodo(
            todo: todo,
            // just to remove error
            key: ValueKey(todo.id),
          ),
        for (var todo in appState.activeUnstaredTodos)
          DismissibleTodo(
            todo: todo,
            // just to remove error
            key: ValueKey(todo.id),
          ),
      ],
    );
  }
}
