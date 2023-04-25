import 'package:flutter/material.dart';
import '../Todo Actions/slide_left_background.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_v2/database/todo.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';

class DismissibleTodo extends StatelessWidget {
  const DismissibleTodo({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Dismissible(
      background: const SlideLeftBackground(),
      key: Key(todo.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        HapticFeedback.mediumImpact();
        appState.deleteTodo(todo.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: colors.secondary,
            content: Text(
              "Task deleted",
              style: TextStyle(color: colors.onSecondary),
            ),
            action: SnackBarAction(
              label: "UNDO",
              onPressed: () async {
                appState.undoTodo(todo);
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
        key: ValueKey(todo.id),
        leading: Radio(
          value: todo.isCompleted ? true : false,
          groupValue: true,
          toggleable: true,
          onChanged: (bool? newValue) =>
              {appState.changeIsComplete(todo), HapticFeedback.lightImpact()},
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(todo.task,
                  style: todo.isCompleted
                      ? TextStyle(
                          color: colors.onSecondary,
                          decoration: TextDecoration.lineThrough)
                      : TextStyle(color: colors.onSecondary)),
            ),
            IconButton(
              color: colors.primary,
              onPressed: () => {
                appState.changeIsImportant(todo),
                HapticFeedback.mediumImpact(),
              },
              icon: todo.isImportant
                  ? const Icon(Icons.star_rate_rounded)
                  : const Icon(Icons.star_border_rounded),
            )
          ],
        ),
      ),
    );
  }
}
