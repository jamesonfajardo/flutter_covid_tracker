import 'package:flutter/material.dart';
import 'const.dart';
import 'customWidgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'credits.dart';

int totalDataCount;

class Settings extends StatefulWidget {
  final int recordCount;
  Settings({this.recordCount});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Map<dynamic, dynamic> poppedData = {
    'id': 'Confirmed',
    'order': 'desc',
    'count': 10,
  };
  void passData() {
    Navigator.pop(context, poppedData);
  }

  // DropdownButtons
  // select 1
  List<String> selectionData1 = [
    'Alphabetic',
    'Confirmed',
    'Recovered',
    'Active',
    'Deaths',
  ];
  String sortItem1 = 'Confirmed';

  DropdownButton select1() {
    List<DropdownMenuItem<String>> option = [];

    selectionData1.forEach((data) {
      var newItem = DropdownMenuItem(
        child: Container(
          width: 120,
          child: Container(
            child: Text(
              data,
            ),
          ),
        ),
        value: data,
      );

      option.add(newItem);
    });

    return DropdownButton<String>(
      underline: Container(
        height: 0,
      ),
      value: sortItem1,
      items: option,
      onChanged: (data) {
        setState(() {
          sortItem1 = data;
        });
        data == 'Alphabetic'
            ? poppedData['id'] = 'Country_Region'
            : poppedData['id'] = data;
      },
    );
  }

  // select 2
  List<String> selectionData2 = [
    'Highest First',
    'Lowest First',
  ];
  String sortItem2 = 'Highest First';

  DropdownButton select2() {
    List<DropdownMenuItem<String>> option = [];

    selectionData2.forEach((data) {
      var newItem = DropdownMenuItem(
        child: Container(
          width: 120,
          child: Text(data),
        ),
        value: data,
      );

      option.add(newItem);
    });

    return DropdownButton<String>(
      underline: Container(
        height: 0,
      ),
      value: sortItem2,
      items: option,
      onChanged: (data) {
        setState(() {
          sortItem2 = data;
        });
        data == 'Highest First'
            ? poppedData['order'] = 'desc'
            : poppedData['order'] = 'asc';
      },
    );
  }

  // select 3
  List<int> selectionData3 = [
    10,
    20,
    30,
    40,
    50,
  ];
  int sortItem3 = 10;

  DropdownButton select3() {
    List<DropdownMenuItem<int>> option = [];

    selectionData3.forEach((data) {
      var newItem = DropdownMenuItem(
        child: Container(
          width: 120,
          child: Text('Show $data items'),
        ),
        value: data,
      );

      option.add(newItem);
    });

    return DropdownButton<int>(
      underline: Container(
        height: 0,
      ),
      value: sortItem3,
      items: option,
      onChanged: (data) {
        setState(() {
          sortItem3 = data;
        });
        poppedData['count'] = data;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      totalDataCount = widget.recordCount;
      selectionData3.add(totalDataCount);
    });
  }

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
                  CDivider(
                    bottomPadding: 16,
                    leftPadding: 16,
                    rightPadding: 16,
                    topPadding: 16,
                  ),
                  select1(),
                  select2(),
                  select3(),
                  CDivider(
                    bottomPadding: 16,
                    leftPadding: 16,
                    rightPadding: 16,
                    topPadding: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (data) {
                        poppedData['region'] = data;
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        filled: true,
                        fillColor: kCard,
                        hintText: 'Search for a Country',
                      ),
                    ),
                  ),
                  CDivider(
                    bottomPadding: 16,
                    leftPadding: 16,
                    rightPadding: 16,
                    topPadding: 16,
                  ),
                  GestureDetector(
                    onTap: passData,
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kRecovered,
                      ),
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Sort Data',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreditsPage())),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    padding: EdgeInsets.all(8),
                    child:
                        // FaIcon(
                        //   FontAwesomeIcons.cog,
                        //   color: kPrimary,
                        //   size: 32,
                        // )
                        SvgPicture.asset(
                      'assets/img/idea.svg',
                      width: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
