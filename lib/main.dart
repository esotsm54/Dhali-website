import 'package:Dhali_website/floating_action.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'bounty.dart';
import 'drawer.dart';
import 'example_bounty.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Dhali'),
        '/bounty': (context) => BountyPage(title: 'Bounty'),
        '/bounty/example': (context) => ExampleBounty(title: 'Example bounty'),
      },
      title: 'Dhali',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // drawer: getDrawer(context),
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                "assets/dhali-logo-clean.svg", // This was cleaner using svgcleaner
                semanticsLabel: 'Logo', fit: BoxFit.scaleDown,
                height: kIsWeb &&
                        (defaultTargetPlatform == TargetPlatform.iOS ||
                            defaultTargetPlatform == TargetPlatform.android)
                    ? 250
                    : 600,
                alignment: Alignment.bottomCenter,
              ),
            ),
            const Align(
                alignment: Alignment.topCenter,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SelectableText(
                      '  The open marketplace for AI  ',
                      style: TextStyle(fontSize: 40),
                    ))),
          ],
        ),
      ),
      floatingActionButton: getPageNavigationActionButton(
          key: const Key("main_page_action_button"),
          context: context,
          label: "Tell us your business problems",
          path: "/bounty"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
