import 'package:Dhali_website/floating_action.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BountyPage extends StatefulWidget {
  const BountyPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<BountyPage> createState() => _BountyPageState();
}

class _BountyPageState extends State<BountyPage> {
  final _formKey = GlobalKey<FormState>();

  String? _emailAddress;
  String? _description;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
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
      body: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.

            child: ListView(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/dhali-logo-clean.svg",
                  semanticsLabel: 'Logo',
                  width: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                BountyForm(
                  formKey: _formKey,
                  setDescription: (description) {
                    setState(() {
                      _description = description;
                    });
                  },
                  setEmailAddress: (emailAddress) {
                    setState(() {
                      _emailAddress = emailAddress;
                    });
                  },
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          )),
      floatingActionButton: getFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  FloatingActionButton? getFloatingActionButton() {
    FloatingActionButton actionButton = FloatingActionButton.extended(
        label: const Text("Submit bounty"),
        onPressed: () {
          SnackBar snackBar;
          if (_formKey.currentState!.validate()) {
            FirebaseFirestore.instance.collection("bounties").doc().set({
              "email": _emailAddress,
              "description": _description,
            });
            snackBar = const SnackBar(
              content: Text("Your bounty was successfully submitted"),
              backgroundColor: Colors.green,
            );
          } else {
            snackBar = const SnackBar(
              content: Text("Your bounty submission failed!"),
              backgroundColor: Colors.red,
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });

    return actionButton;
  }
}

class BountyForm extends StatefulWidget {
  const BountyForm(
      {super.key,
      required this.formKey,
      required this.setEmailAddress,
      required this.setDescription});

  final Function(String) setEmailAddress;
  final Function(String) setDescription;

  final formKey;

  @override
  State<BountyForm> createState() => _BountyFormState();
}

class _BountyFormState extends State<BountyForm> {
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        TextStyle(color: Color.fromARGB(255, 101, 101, 101), fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SelectableText(
            'Create a bounty describing an AI problem that '
            'you need solving.\n\nOur community will do the rest!',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        const SizedBox(
          height: 40,
        ),
        RichText(
          text: TextSpan(
            style: defaultStyle,
            children: <TextSpan>[
              TextSpan(
                  text: 'See an example of bounty created for our community '),
              TextSpan(
                  text: 'here',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/bounty/example');
                    }),
            ],
          ),
        ),
        Form(
            key: widget.formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  onChanged: (String text) {
                    widget.setEmailAddress(text);
                  },
                  validator: (value) {
                    String errorMessage = 'Please a valid email address';
                    if (value == null || value.isEmpty) {
                      return errorMessage;
                    }
                    if (RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return null;
                    }

                    return errorMessage;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    labelText: 'Email address',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  onChanged: (String text) {
                    widget.setDescription(text);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your problem description';
                    }
                    return null;
                  },
                  maxLines: 10,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    labelText: 'Problem description',
                  ),
                ),
              ),
            ]))
      ],
    );
  }
}
