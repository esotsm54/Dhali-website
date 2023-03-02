import 'package:flutter/material.dart';

FloatingActionButton? getPageNavigationActionButton({
  Key? key,
  required BuildContext context,
  required String label,
  required String path,
}) {
  FloatingActionButton actionButton = FloatingActionButton.extended(
    key: key,
    label: Text(label),
    backgroundColor: Color.fromARGB(255, 76, 0, 255),
    onPressed: () {
      Navigator.pushNamed(context, path);
    },
  );

  return actionButton;
}
