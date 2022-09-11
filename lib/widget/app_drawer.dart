//--------------------------------------------------
// This widget shows the app drawer
//--------------------------------------------------

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//--------------------------------------------------
// These are internal screens imports.
//--------------------------------------------------
import '../Screens/comparison_screen.dart';
import '../Screens/favourites_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/setting_screen.dart';

class AppDrawer extends StatelessWidget {
  static const Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(children: [
          Container(
            color: Theme.of(context).backgroundColor,
            height: 57,
          ),
          ListTile(
            leading: Text(
              'Favorites',
              style: TextStyle(color: textColor),
            ),
            trailing: Icon(Icons.favorite, color: textColor),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FavoriteScreen.routeName);
            },
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.white24,
          ),
          ListTile(
            leading: Text(
              'List',
              style: TextStyle(color: textColor),
            ),
            trailing: Icon(
              FontAwesomeIcons.list,
              color: textColor,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => HomeScreen()));
            },
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.white24,
          ),
          ListTile(
            leading: Text(
              'Comparison',
              style: TextStyle(color: textColor),
            ),
            trailing: Icon(FontAwesomeIcons.chartBar, color: textColor),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ComparisonWidget.routeName);
            },
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.white24,
          ),
          ListTile(
            leading: Text(
              'Setting',
              style: TextStyle(color: textColor),
            ),
            trailing: Icon(Icons.settings, color: textColor),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SettingsScreen.routeName);
            },
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.white24,
          ),
        ]),
      ),
    );
  }
}
