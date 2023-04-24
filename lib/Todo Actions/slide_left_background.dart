import 'package:flutter/material.dart';

class SlideLeftBackground extends StatelessWidget {
  const SlideLeftBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.errorContainer,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: colors.onErrorContainer,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
