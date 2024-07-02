import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showModal(BuildContext context, VoidCallback onTap, String title, String content) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onTap,
          child: const Text('SÍ'),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('CANCELAR'),
        ),
      ],
    ),
  );
}
