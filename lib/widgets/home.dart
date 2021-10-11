import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metar/constants/constants.dart';
import 'package:metar/models/metar.dart';
import 'package:metar/providers/api.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'appbar/custom.appbar.dart';
import 'listview/screenshot.listview.dart';
import 'listview/stations.listview.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    fetchMetar();
    super.initState();
  }

  String lastUpdated = '';
  bool _isInAsyncCall = false;
  Future<void> fetchMetar() async {
    setState(() {
      _isInAsyncCall = true;
    });
    List<Metar> responseMetars = await new Api().fetchMetarCheckWX(stations);
    setState(() {
      metars = [...responseMetars];
      lastUpdated = DateFormat('d MMM hh:mm:ss').format(DateTime.now());
      foundMetars = metars;
      _isInAsyncCall = false;
    });
    print(metars);
  }

  void _runFilter(String enteredKeyword) {
    List<Metar> results = [];
    if (enteredKeyword.isEmpty) {
      results = metars;
    } else {
      results = metars
          .where((user) =>
              user.reading.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundMetars = results;
    });
  }

  List<Metar> metars = [];
  List<Metar> foundMetars = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(lastUpdated: lastUpdated, widget: widget),
        body: TabBarView(
          children: [
            ModalProgressHUD(
              inAsyncCall: _isInAsyncCall,
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: 12, left: 12, top: 2, bottom: 8),
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                        labelText: 'Search',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Icon(Icons.search),
                      ),
                      // maxLength: 4,
                    ),
                  ),
                  Expanded(
                    child: foundMetars.length > 0
                        ? StationsListView(
                            entries: foundMetars,
                            fetchMetar: fetchMetar,
                          )
                        : Text(
                            _isInAsyncCall ? 'Loading' : 'No results found',
                            style: TextStyle(fontSize: 24),
                          ),
                  ),
                ],
              ),
            ),
            ScreenshotListView(
                isInAsyncCall: _isInAsyncCall,
                entries: metars,
                fetchMetar: fetchMetar),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchMetar,
          tooltip: 'Increment',
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
