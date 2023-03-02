import 'package:flutter/material.dart';

FloatingActionButton? getPageNavigationActionButton(
    BuildContext context, String label, String path) {
  FloatingActionButton actionButton = FloatingActionButton.extended(
    label: Text(label),
    backgroundColor: Color.fromARGB(255, 76, 0, 255),
    onPressed: () {
      Navigator.pushNamed(context, path);
    },
  );

  return actionButton;
}
