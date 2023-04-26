import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../App State/app_state.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: const Icon(
        Icons.add_rounded,
        size: 35,
      ),
      onPressed: () {
        showAnimatedDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            // variable to store input textfield data
            var myController = TextEditingController();

            return AlertDialog(
              backgroundColor: colors.secondary,
              scrollable: true,
              // title: const Text("Add new task"),
              content: Form(
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: true,
                      autofocus: true,
                      controller: myController,
                      decoration: const InputDecoration(
                        labelText: "New Task",
                        icon: Icon(Icons.add_circle_outline),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                FilledButton.tonal(
                  child: const Text("Add"),
                  onPressed: () async {
                    HapticFeedback.lightImpact();
                    int added = await appState.createTodo(myController.text);
                    Navigator.pop(context, false);
                    if (added == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: colors.primaryContainer,
                          duration: const Duration(seconds: 1),
                          content: Text(
                            'New Task Added',
                            style: TextStyle(color: colors.onPrimaryContainer),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: colors.errorContainer,
                          duration: const Duration(seconds: 1),
                          content: Text(
                            'Enter Valid Task',
                            style: TextStyle(color: colors.onErrorContainer),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
