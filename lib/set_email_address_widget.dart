import 'package:flutter/material.dart';

class SetEmailAddress extends StatefulWidget {
  const SetEmailAddress({
    super.key,
    required this.formKey,
    required this.setEmailAddress,
  });

  final Function(String) setEmailAddress;

  final formKey;

  @override
  State<SetEmailAddress> createState() => _SetEmailAddressState();
}

class _SetEmailAddressState extends State<SetEmailAddress> {
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        TextStyle(color: Color.fromARGB(255, 101, 101, 101), fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Form(
            key: widget.formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                child: TextFormField(
                  onChanged: (String text) {
                    widget.setEmailAddress(text);
                  },
                  validator: (value) {
                    String errorMessage = 'Please enter a valid email address';
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
            ]))
      ],
    );
  }
}
