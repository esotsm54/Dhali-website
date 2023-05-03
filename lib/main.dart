import 'package:Dhali_website/buttons.dart';
import 'package:Dhali_website/footer.dart';
import 'package:Dhali_website/set_email_address_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'bounty.dart';
import 'drawer.dart';
import 'example_bounty.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  runApp(MyApp(
    analytics: analytics,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.analytics});
  final FirebaseAnalytics analytics;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(
              title: 'Dhali',
              analytics: analytics,
            ),
        '/bounty': (context) => BountyPage(
              title: 'Bounty',
              analytics: analytics,
            ),
        '/bounty/example': (context) => ExampleBounty(
              title: 'Example bounty',
              analytics: analytics,
            ),
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
  const MyHomePage({super.key, required this.title, required this.analytics});
  final FirebaseAnalytics analytics;

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
  String? _emailAddress;
  final _formKey = GlobalKey<FormState>(debugLabel: "submit_emails_form_key");
  @override
  Widget build(BuildContext context) {
    widget.analytics.logAppOpen();
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
        child: FooterView(
          footer: getFooter(),
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
                      'Dhali levels the playing field by providing an\nopen marketplace that offers cutting-edge AI solutions',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ))),
            const SizedBox(
              height: 50,
            ),
            const Align(
                alignment: Alignment.topCenter,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SelectableText(
                      'Add your email, if you are interested in joining Dhali',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ))),
            const SizedBox(
              height: 50,
            ),
            SetEmailAddress(
              formKey: _formKey,
              setEmailAddress: (emailAddress) {
                setState(() {
                  _emailAddress = emailAddress;
                });
              },
            ),
            getElevatedButton(
                key: const Key("add-email-button"),
                context: context,
                label: "Submit email",
                onPressed: () {
                  SnackBar snackBar;
                  bool error = false;
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection("emails-from-ads")
                        .doc()
                        .set({
                      "email": _emailAddress,
                    }).then((value) {
                      snackBar = const SnackBar(
                        content: Text("Your email was successfully submitted"),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }).onError((error, stackTrace) {
                      snackBar = const SnackBar(
                        key: Key("failed-submission"),
                        content: Text("Your email submission failed!"),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
