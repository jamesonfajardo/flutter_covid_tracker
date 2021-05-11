import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

// url launcher row
class UrlLauncherRow extends StatelessWidget {
  UrlLauncherRow({this.url, this.icon, this.label, this.color});
  final String url;
  final Widget icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(3, 1, 0, 1),
      color: color,
      width: 120,
      margin: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
        child: Row(
          children: <Widget>[
            icon ?? Icon(Icons.label),
            Expanded(
              child: Container(
                child: Text(
                  label ?? 'label',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// url launcher column
class UrlLauncherColumn extends StatelessWidget {
  UrlLauncherColumn({this.icon, this.label, this.url});

  final String url;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
        child: Column(
          children: <Widget>[
            icon ?? Icon(Icons.label),
            Text(label ?? 'label goes here'),
          ],
        ),
      ),
    );
  }
}

// loading label
class LoadingLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitWave(
          color: Colors.white,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

// header
class Header extends StatelessWidget {
  Header(
      {this.image, this.confirmed, this.recovered, this.active, this.deaths});

  final Widget image;
  final double confirmed;
  final double recovered;
  final double active;
  final double deaths;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          image,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ColoredText(
                icon: CenterIcon(
                  icon: FontAwesomeIcons.userAlt,
                ),
                label:
                    'Confirmed: ${FlutterMoneyFormatter(amount: confirmed).output.withoutFractionDigits}',
                color: Colors.white,
              ),
              ColoredText(
                icon: CenterIcon(
                  icon: FontAwesomeIcons.handHoldingMedical,
                  iconColor: kRecovered,
                ),
                label:
                    'Recovered: ${FlutterMoneyFormatter(amount: recovered).output.withoutFractionDigits}',
                color: kRecovered,
              ),
              ColoredText(
                icon: CenterIcon(
                  icon: FontAwesomeIcons.lungsVirus,
                  iconColor: kActive,
                ),
                label:
                    'Active: ${FlutterMoneyFormatter(amount: active).output.withoutFractionDigits}',
                color: kActive,
              ),
              ColoredText(
                icon: CenterIcon(
                  icon: FontAwesomeIcons.skullCrossbones,
                  iconColor: kDeaths,
                ),
                label:
                    'Deaths: ${FlutterMoneyFormatter(amount: deaths).output.withoutFractionDigits}',
                color: kDeaths,
              ),
            ],
          )
        ],
      ),
    );
  }
}

// CenterIcon
class CenterIcon extends StatelessWidget {
  final double width;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  CenterIcon({this.icon, this.width, this.iconColor, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 32,
      child: Center(
        child: FaIcon(
          icon ?? FontAwesomeIcons.infinity,
          size: iconSize ?? 16,
          color: iconColor ?? Colors.white,
        ),
      ),
    );
  }
}

// Cdivider
class CDivider extends StatelessWidget {
  CDivider({
    this.bottomPadding,
    this.leftPadding,
    this.rightPadding,
    this.topPadding,
  });
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.blueGrey[800],
      margin: EdgeInsets.fromLTRB(leftPadding ?? 8, topPadding ?? 8,
          rightPadding ?? 8, bottomPadding ?? 8),
    );
  }
}

// colored text
class ColoredText extends StatelessWidget {
  ColoredText({this.icon, this.color, this.label, this.fontSize});
  final Widget icon;
  final Color color;
  final label;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: icon ??
                FaIcon(
                  FontAwesomeIcons.infinity,
                  size: 16,
                ),
          ),
          Text(
            '${label ?? 'label here'}',
            style: TextStyle(
              color: color,
              fontSize: fontSize ?? 18,
            ),
          ),
        ],
      ),
    );
  }
}

// country data
class CountryData extends StatelessWidget {
  final String countryName;
  final int confirmed;
  final int recovered;
  final int active;
  final int deaths;

  CountryData({
    this.active,
    this.confirmed,
    this.countryName,
    this.deaths,
    this.recovered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${countryName ?? 'country name'}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              ConfirmCard(
                label:
                    '${FlutterMoneyFormatter(amount: confirmed.toDouble() ?? 0).output.withoutFractionDigits}',
              ),
              RecoverCard(
                label:
                    '${FlutterMoneyFormatter(amount: recovered.toDouble() ?? 0).output.withoutFractionDigits}',
              ),
              ActiveCard(
                label:
                    '${FlutterMoneyFormatter(amount: active.toDouble() ?? 0).output.withoutFractionDigits}',
              ),
              DeathCard(
                label:
                    '${FlutterMoneyFormatter(amount: deaths.toDouble() ?? 0).output.withoutFractionDigits}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// confirm card
class ConfirmCard extends StatelessWidget {
  ConfirmCard({this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(4),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CenterIcon(
              icon: FontAwesomeIcons.userAlt,
              iconSize: 20,
            ),
            SizedBox(width: 8),
            Text(
              '${label ?? '123,456,789'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// recovered card
class RecoverCard extends StatelessWidget {
  RecoverCard({this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(4),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CenterIcon(
              icon: FontAwesomeIcons.handHoldingMedical,
              iconSize: 20,
              iconColor: kRecovered,
            ),
            SizedBox(width: 8),
            Text(
              '${label ?? '123,456,789'}',
              style: TextStyle(
                color: kRecovered,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// active card
class ActiveCard extends StatelessWidget {
  ActiveCard({this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(4),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CenterIcon(
              icon: FontAwesomeIcons.lungsVirus,
              iconSize: 20,
              iconColor: kActive,
            ),
            SizedBox(width: 8),
            Text(
              '${label ?? '123,456,789'}',
              style: TextStyle(
                color: kActive,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// death card
class DeathCard extends StatelessWidget {
  DeathCard({this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(4),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CenterIcon(
              icon: FontAwesomeIcons.skullCrossbones,
              iconSize: 20,
              iconColor: kDeaths,
            ),
            SizedBox(width: 8),
            Text(
              '${label ?? '123,456,789'}',
              style: TextStyle(
                color: kDeaths,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
