import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';

class DeleteTodo extends StatelessWidget {
  const DeleteTodo({super.key, required this.todo});
  final String todo;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return IconButton(
      icon: const Icon(Icons.delete_outline_rounded),
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
