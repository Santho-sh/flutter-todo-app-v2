import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    if (appState.completedTodos.isEmpty) {
      return const SizedBox.shrink();
    }

    return ReorderableListView(
      shrinkWrap: true,
      header: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            "Completed",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      onReorder: (oldIndex, newIndex) =>
          appState.changeCompletedIndex(oldIndex, newIndex),
      children: [
        for (var activeTodo in appState.completedTodos)
          ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: const Color.fromARGB(255, 35, 35, 35),
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
                IconButton(
                  onPressed: () => appState.deleteTodo(activeTodo),
                  icon: const Icon(Icons.delete_outline_rounded),
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
