import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:Dhali_website/main.dart';

Widget getDrawer(BuildContext context) {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(name: "drawer-opened");
  return Drawer(
    backgroundColor: Colors.white,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Text(
            'Dhali',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Bounty'),
          onTap: () {
            Navigator.pushNamed(context, '/bounty');
          },
        ),
      ],
    ),
  );
}
