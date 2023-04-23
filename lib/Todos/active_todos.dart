import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';

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
          ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            tileColor: const Color.fromARGB(255, 26, 26, 26),
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
                    style: const TextStyle(),
                  ),
                ),
                IconButton(
                  onPressed: () => appState.markComplete(activeTodo),
                  icon: const Icon(Icons.star_border_rounded),
                )
              ],
            ),
          ),
      ],
    );
  }
}
