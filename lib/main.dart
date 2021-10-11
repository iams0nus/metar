import 'package:flutter/material.dart';
import 'package:metar/widgets/home.dart';

import 'colors/material.colors.dart';

void main() {
  runApp(MetarApp());
}

class MetarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Metar',
        theme: ThemeData(
            primarySwatch: darkBlue,
            fontFamily: 'Lato',
            scaffoldBackgroundColor: lightBlue),
        home: MyHomePage(title: 'METAR'),
      ),
    );
  }
}
