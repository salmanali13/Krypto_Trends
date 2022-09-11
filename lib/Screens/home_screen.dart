//-----------------------------------------------------------
// This is the home screen that renders FutureBuilder screen
//-----------------------------------------------------------

//External Imports------------
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//Internal Imports------------
import '/Screens/future_builder.dart';
import '/widget/app_drawer.dart';
import '/widget/currency_dialog.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  DateTime lastPressed = DateTime.now();
  bool isSearchOpen = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(lastPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        lastPressed = DateTime.now();
        if (isExitWarning) {
          Fluttertoast.showToast(msg: "Tap Again to Exit");
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          leading: Builder(
              builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(FontAwesomeIcons.alignLeft))),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     isSearchOpen = !isSearchOpen;
            //   },
            //   icon: Icon(Icons.search_rounded),
            // ),
            CurrencyDialog(),
          ],
          title: Text(
            'The Krypto',
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FutureBuilderScreen(isSearchOpen)),
            ],
          ),
        ),
      ),
    );
  }
}
