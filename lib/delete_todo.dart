import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class DeleteTodo extends StatelessWidget {
  const DeleteTodo({super.key, required this.todo});
  final String todo;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return IconButton(
      icon: const Icon(Icons.delete_outline_rounded),
      style: IconButton.styleFrom(
        iconSize: 20,
        foregroundColor: colors.onSecondaryContainer,
        backgroundColor: colors.secondaryContainer,
        disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
        hoverColor: colors.onSecondaryContainer.withOpacity(0.08),
        focusColor: colors.onSecondaryContainer.withOpacity(0.12),
        highlightColor: colors.onSecondaryContainer.withOpacity(0.12),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: const Text("Confirm Delete?"),
              actions: [
                FilledButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No'),
                ),
                FilledButton(
                  onPressed: () => {
                    appState.deleteTodo(todo),
                    Navigator.pop(context, false),
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
