import 'package:flutter/material.dart';
import 'customWidgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'network.dart';
import 'dart:convert';
import 'settings.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // get entire records
  Network apiCall = Network(
      url:
          'https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query?f=json&where=confirmed%3E0&geometryType=esriGeometryEnvelope&spatialRef=esriSpatialRelIntersects&outFields=*&orderByFields=Confirmed%20desc&resultOffset=0&cacheHint=true&returnGeometry=false');

  // variables
  var globalRawData;
  var globalJsonBody;
  int statusCode;

  double totalConfirmed = 0;
  double totalRecovered = 0;
  double totalActive = 0;
  double totalDeaths = 0;

  List<String> localCountryName = [];
  List<int> localConfirmed = [];
  List<int> localRecovered = [];
  List<int> localActive = [];
  List<int> localDeaths = [];

  // initial list view data
  ListView initialListViewData() {
    List<Widget> listViewChildren = [];

    for (int i = 0; i < 10; i++) {
      Widget newItem = CountryData(
        countryName: localCountryName[i],
        confirmed: localConfirmed[i],
        recovered: localRecovered[i],
        active: localActive[i],
        deaths: localDeaths[i],
      );

      listViewChildren.add(newItem);
    }

    return ListView(
      children: listViewChildren,
    );
  }

  // process API
  void processApi() async {
    globalRawData = await apiCall.processUrl();
    globalJsonBody = jsonDecode(globalRawData.body)['features'];
    distributeValues(globalJsonBody: globalJsonBody);
  }

  // distribute values
  void distributeValues({var globalJsonBody}) {
    setState(() {
      int dataLength = globalJsonBody.length;
      for (int i = 0; i < dataLength; i++) {
        totalConfirmed += globalJsonBody[i]['attributes']['Confirmed'];
        totalRecovered += globalJsonBody[i]['attributes']['Recovered'];
        totalActive += globalJsonBody[i]['attributes']['Active'];
        totalDeaths += globalJsonBody[i]['attributes']['Deaths'];

        localCountryName.add(
            '${globalJsonBody[i]['attributes']['Country_Region']} ${globalJsonBody[i]['attributes']['Province_State'] == null ? '' : '- ${globalJsonBody[i]['attributes']['Province_State']}'}');
        localConfirmed.add(globalJsonBody[i]['attributes']['Confirmed']);
        localRecovered.add(globalJsonBody[i]['attributes']['Recovered']);
        localActive.add(globalJsonBody[i]['attributes']['Active']);
        localDeaths.add(globalJsonBody[i]['attributes']['Deaths']);
      }
    });
  }

  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------

  // dynamic list view data
  var poppedRawData;
  var poppedJsonBody;

  List<String> poppedCountryName = [];
  List<int> poppedConfirmed = [];
  List<int> poppedRecovered = [];
  List<int> poppedActive = [];
  List<int> poppedDeaths = [];

  ListView dynamicListViewData() {
    List<Widget> listViewChildren = [];
    int dataLength = poppedCountryName.length;

    for (int i = 0; i < dataLength; i++) {
      Widget newItem = CountryData(
        countryName: poppedCountryName[i],
        confirmed: poppedConfirmed[i],
        recovered: poppedRecovered[i],
        active: poppedActive[i],
        deaths: poppedDeaths[i],
      );

      listViewChildren.add(newItem);
    }

    return ListView(
      children: listViewChildren,
    );
  }

  bool isPoppedDataAvailable = false;
  bool isRegionAvailable = true;

  void showPoppedData() {
    isPoppedDataAvailable = true;
  }

  void processPoppedApi() async {
    poppedRawData = await apiCall.processUrl();
    poppedJsonBody = jsonDecode(poppedRawData.body)['features'];
    if (poppedJsonBody.length == 0) {
      print('no records found');
      setState(() {
        isRegionAvailable = false;
      });
    } else {
      distributePoppedData(poppedJsonBody: poppedJsonBody);
      isRegionAvailable = true;
    }
  }

  void distributePoppedData({var poppedJsonBody}) {
    setState(() {
      int dataLength = poppedJsonBody.length;
      for (int i = 0; i < dataLength; i++) {
        poppedCountryName.add(
            '${poppedJsonBody[i]['attributes']['Country_Region']} ${poppedJsonBody[i]['attributes']['Province_State'] == null ? '' : '- ${poppedJsonBody[i]['attributes']['Province_State']}'}');
        poppedConfirmed.add(poppedJsonBody[i]['attributes']['Confirmed']);
        poppedRecovered.add(poppedJsonBody[i]['attributes']['Recovered']);
        poppedActive.add(poppedJsonBody[i]['attributes']['Active']);
        poppedDeaths.add(poppedJsonBody[i]['attributes']['Deaths']);
      }
    });
  }

  // settings route
  void settingsPageRoute() async {
    var poppedData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Settings(
                  recordCount: localCountryName.length,
                )));

    if (poppedData != null) {
      // print(poppedData['id']);
      // print(poppedData['order']);
      // print(poppedData['count']);
      // print(poppedData['region']);
      poppedJsonBody = null;
      poppedCountryName.clear();
      poppedConfirmed.clear();
      poppedRecovered.clear();
      poppedActive.clear();
      poppedDeaths.clear();
      setState(() {
        apiCall = Network(
            url:
                'https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/1/query?f=json&where=Confirmed>0${poppedData['region'] == null ? '' : '%20and%20Country_Region%20like%20%27%${poppedData['region']}%%27%20or%20Province_State%20like%20%27%${poppedData['region']}%%27'}&geometryType=esriGeometryEnvelope&spatialRef=esriSpatialRelIntersects&outFields=*&orderByFields=${poppedData['id']}%20${poppedData['order']}&resultOffset=0&cacheHint=true&returnGeometry=false&resultRecordCount=${poppedData['region'] == null ? poppedData['count'] ?? '' : ''}');
        processPoppedApi();
        showPoppedData();
      });
    }
  }

  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------

  // widget lifecycle
  @override
  void initState() {
    super.initState();
    processApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Header(
              image: SvgPicture.asset(
                'assets/img/globe.svg',
                width: 130,
              ),
              active: totalActive,
              confirmed: totalConfirmed,
              deaths: totalDeaths,
              recovered: totalRecovered,
            ),
            CDivider(
              bottomPadding: 8,
              leftPadding: 16,
              rightPadding: 16,
              topPadding: 16,
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                globalJsonBody == null
                    ? Center(child: LoadingLabel())
                    : isPoppedDataAvailable == false
                        ? initialListViewData()
                        : poppedJsonBody == null
                            ? Center(child: LoadingLabel())
                            : isRegionAvailable == true
                                ? dynamicListViewData()
                                : Center(
                                    child: Text(
                                        'Search did not match any records')),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: settingsPageRoute,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      padding: EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        'assets/img/automation.svg',
                        width: 50,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        )),
      ),
    );
  }
}
