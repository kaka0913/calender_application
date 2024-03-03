// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoActionSheet extends StatelessWidget {
  const CustomCupertinoActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            '編集を破棄',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'キャンセル',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
