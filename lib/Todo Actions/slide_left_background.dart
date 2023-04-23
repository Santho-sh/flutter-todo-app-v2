import 'package:flutter/material.dart';

class SlideLeftBackground extends StatelessWidget {
  const SlideLeftBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),

            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
