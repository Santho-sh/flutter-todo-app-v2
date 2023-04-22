import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return ReorderableListView(
      padding: const EdgeInsets.all(8.0),
      onReorder: (oldIndex, newIndex) =>
          appState.changeIndex(oldIndex, newIndex),
      children: [
        for (var activeTodo in appState.activeTodos)
          ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: const Color.fromARGB(255, 35, 35, 35),
            key: ValueKey(activeTodo),
            leading: const Icon(Icons.adjust),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    activeTodo,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: () => appState.markComplete(activeTodo),
                  icon: const Icon(Icons.check),
                  style: IconButton.styleFrom(
                    iconSize: 20,
                    foregroundColor: colors.onSecondaryContainer,
                    backgroundColor: colors.secondaryContainer,
                    disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
                    hoverColor: colors.onSecondaryContainer.withOpacity(0.08),
                    focusColor: colors.onSecondaryContainer.withOpacity(0.12),
                    highlightColor:
                        colors.onSecondaryContainer.withOpacity(0.12),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
