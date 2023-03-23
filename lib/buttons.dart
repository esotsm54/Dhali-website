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
    backgroundColor: const Color.fromARGB(255, 76, 0, 255),
    onPressed: () {
      Navigator.pushNamed(context, path);
    },
  );

  return actionButton;
}

Widget getPageNavigationElevatedButton({
  Key? key,
  required BuildContext context,
  required String label,
  required String path,
}) {
  return Center(
      key: key,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, path);
          },
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: const Color.fromARGB(255, 76, 0, 255)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(label),
          )));
}
