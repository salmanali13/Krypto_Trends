//-----------------------------------------------------------
// This screen shows the settings screen
//-----------------------------------------------------------

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:share_plus/share_plus.dart';

//-----------------------------------------------------------
// These are internal library imports i.e. Screens and widgets
//-----------------------------------------------------------
import '/Screens/privacy_policy_screen.dart';
import '../widget/app_drawer.dart';
import 'home_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/setting-screen";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ));
        return;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: AppDrawer(),
        appBar: AppBar(
          leading: Builder(
              builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(FontAwesomeIcons.alignLeft))),
          title: Text('Settings'),
        ),
        body: Column(
          children: <Widget>[
            buildListTile("Privacy Policy", FontAwesomeIcons.info, context),
            buildListTile(
                "Share App with Others", FontAwesomeIcons.share, context),
            buildListTile("More from US", Icons.more_horiz_rounded, context),
          ],
        ),
      ),
    );
  }
}

//-----------------This is the Builder Method--------------------

Widget buildListTile(String name, IconData icon, BuildContext ctx) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.symmetric(
      vertical: 7,
      horizontal: 8,
    ),
    color: Color.fromRGBO(35, 56, 70, 1.0),
    child: ListTile(
      title: Text(name,
          textAlign: TextAlign.center, style: TextStyle(color: Colors.white54)),
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white12,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
      onTap: () async {
        switch (name) {
          case "Privacy Policy":
            {
              // Here we have to push the Privacy Policy text screen
              //----------------------------------------------------
              Navigator.of(ctx).push(
                MaterialPageRoute(
                  builder: (c) => PrivacyPolicySCreen(),
                ),
              );
            }

            break;
          case "Share App with Others":
            {
              // Here we have to Pass the link to our app to share on whatsapp
              //----------------------------------------------------
              Share.share(
                  'check out This Cryptocurrency Trends App https://play.google.com/store/apps/details?id=com.crypto.trends.cryptocurrency.prices.market.cap.cyptographs.app');
            }

            break;
          case "More from US":
            {
              // Here we have to Pass the link to Play Console account
              //----------------------------------------------------
              await StoreRedirect.redirect(
                androidAppId:
                    "com.crypto.trends.cryptocurrency.prices.market.cap.cyptographs.app",
              );
            }

            break;
        }
      },
    ),
  );
}
