import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';
import 'package:todo_app_v2/Todo Actions/slide_left_background.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    if (appState.completedTodos.isEmpty) {
      return const SizedBox.shrink();
    }

    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      childrenPadding: const EdgeInsets.only(left: 8, right: 8),
      title: const Text("Completed"),
      children: <Widget>[
        for (var completedTodo in appState.completedTodos)
          Dismissible(
            background: const SlideLeftBackground(),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              appState.removeTodo(completedTodo);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: colors.secondary,
                  content: Text(
                    "Task deleted",
                    style: TextStyle(color: colors.onSecondary),
                  ),
                  action: SnackBarAction(
                    label: "UNDO",
                    textColor: Colors.green,
                    onPressed: () {
                      appState.addCompletedTodo(completedTodo);
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
                value: true,
                groupValue: true,
                toggleable: true,
                onChanged: (_) => {appState.markUncomplete(completedTodo)},
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      completedTodo,
                      style: const TextStyle(),
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
