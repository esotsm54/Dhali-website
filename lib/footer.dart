import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footer/footer.dart';
import 'package:url_launcher/url_launcher.dart';

Footer getFooter() {
  return Footer(
    padding: const EdgeInsets.all(5.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 45.0,
                    width: 45.0,
                    child: Center(
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // half of height and width of Image
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.twitter,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            Uri url = Uri.parse("https://twitter.com/dhali_io");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw "Could not launch $url";
                            }
                          },
                        ),
                      ),
                    )),
                Container(
                    height: 45.0,
                    width: 45.0,
                    child: Center(
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // half of height and width of Image
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.github,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            Uri url = Uri.parse("https://github.com/Dhali-org");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw "Could not launch $url";
                            }
                          },
                        ),
                      ),
                    )),
                Container(
                    height: 45.0,
                    width: 45.0,
                    child: Center(
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // half of height and width of Image
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.youtube,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            Uri url = Uri.parse(
                                "https://www.youtube.com/channel/UC8Mx_KbOQ4E7y50mSmlTx4w");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw "Could not launch $url";
                            }
                          },
                        ),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(height: 10),
          const Text(
            'Copyright ©2023  Dhali, All Rights Reserved.',
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
                color: Color(0xFF162A49)),
          ),
        ]),
  );
}
