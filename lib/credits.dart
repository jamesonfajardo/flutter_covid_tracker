import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'customWidgets.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                    child: FaIcon(FontAwesomeIcons.backspace),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      children: <Widget>[
                        CDivider(
                          bottomPadding: 16,
                          leftPadding: 16,
                          rightPadding: 16,
                          topPadding: 16,
                        ),
                        UrlLauncherColumn(
                          icon: FaIcon(
                            FontAwesomeIcons.windowRestore,
                            size: 86,
                          ),
                          label: 'Online Tracker',
                          url: 'https://indexcodex.com',
                        ),
                        UrlLauncherColumn(
                          icon: FaIcon(
                            FontAwesomeIcons.paypal,
                            size: 86,
                          ),
                          label: 'Donate',
                          url:
                              "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=99porings@gmail.com&lc=US&item_name=If you like our Covid-19 tracker, you may consider donating any amount to support our craft. Thank you and stay safe!&no_note=0&cn=&curency_code=USD&bn=PP-DonationsBF:btn_donateCC_LG.gif:NonHosted",
                        ),
                        UrlLauncherColumn(
                          icon: FaIcon(
                            FontAwesomeIcons.envelope,
                            size: 86,
                          ),
                          label: 'Contact Us',
                          url:
                              'mailto:indexcodex.ixcx@gmail.com?subject=Hi indexcodex!&body=type your message here :)',
                        ),
                        CDivider(
                          bottomPadding: 16,
                          leftPadding: 16,
                          rightPadding: 16,
                          topPadding: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
