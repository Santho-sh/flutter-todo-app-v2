import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';
import '../Todo Actions/slide_left_background.dart';

class ActiveTodos extends StatelessWidget {
  const ActiveTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    if (appState.activeTodos.isEmpty) {
      return const SizedBox.shrink();
    }

    return ReorderableListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 8, right: 8),
      onReorder: (oldIndex, newIndex) =>
          appState.changeIndex(oldIndex, newIndex),
      children: [
        for (var activeTodo in appState.activeTodos)
          Dismissible(
            background: const SlideLeftBackground(),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              appState.removeTodo(activeTodo);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: colors.secondary,
                  content: Text(
                    "Task deleted",
                    style: TextStyle(color: colors.onSecondary),
                  ),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      appState.addTodo(activeTodo);
                    },
                  ),
                ),
              );
            },
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: colors.background),
                borderRadius: BorderRadius.circular(5),
              ),
              tileColor: colors.secondary,
              key: UniqueKey(),
              leading: Radio(
                value: false,
                groupValue: true,
                toggleable: true,
                onChanged: (bool? newValue) =>
                    {appState.markComplete(activeTodo)},
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      activeTodo,
                      style: TextStyle(color: colors.onSecondary),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.star_border_rounded),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
