//------------------------------------------------------------------------------
// This is the root file of the application the RunApp (main.dart)

// External Imports-------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_krypto_trends/services/firebase_analytics.dart';

// Internal Imports-------------------------------------
import './Screens/home_screen.dart';
import './models/Crypto_model.dart';
import './models/Cyrpto_price_graph.dart';
import './Screens/comparison_screen.dart';
import './Screens/favourites_screen.dart';
import './Screens/setting_screen.dart';
import './models/curruncy_Converter.dart';
import './models/favourite_model.dart';

//This is a global variable that can be accessed anywhere in the App
//It would be initiallized only upon launcing of app.
bool upperNotification = true;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//  ------------------------------------------------------
// These are the providers (Models) used throughout the app
//            in different screens and widgets...
//  ------------------------------------------------------
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Curruncies()),
        ChangeNotifierProvider.value(value: CryptoGraphsCurruncies()),
        ChangeNotifierProvider.value(value: Favourites()),
        ChangeNotifierProvider.value(value: ListOfCurruncies()),
      ],
      child: MyApp(),
    ),
  );
}
//  ------------------------------------------------------
// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  // ---------This widget is the root of application---------
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    if (isInit) {
      // final myTrace = FirebasePerformanceService()
      //     .traceBuilder("-Startup Cache loading Trace-");
      // myTrace.start();
      Provider.of<Favourites>(context, listen: false)
          .declarePrefs()
          .then((value) {
        // myTrace.stop();
        isInit = false;
      });
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black26,
      statusBarIconBrightness: Brightness.light,
    ));
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshotFirbase) {
          if (snapshotFirbase.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'The Krypto Trends',

              navigatorObservers: [
                FirebaseAnalyticsService().getAnalyticsObserver()
              ],
              //----------This is the theme of the whole app----------
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.red,
                      statusBarBrightness: Brightness.light,
                    ),
                    backgroundColor: Color.fromRGBO(30, 42, 51, 1.0),
                    centerTitle: true,
                    textTheme: TextTheme(
                        headline6: GoogleFonts.quicksand(
                            color: Colors.white, fontSize: 22)),
                    backwardsCompatibility: true,
                    shadowColor: Colors.transparent),
                accentColor: Colors.amber,
                textTheme: TextTheme(
                  //This is the main body text--------------------------
                  bodyText2: GoogleFonts.quicksand(color: Colors.white54),
                  //----------------------------------------------------
                  bodyText1: GoogleFonts.quicksand(color: Colors.white),
                  //This is for Titles of ListTiles---------------------
                  subtitle1: GoogleFonts.quicksand(color: Colors.white70),
                  //----------------------------------------------------
                  //----------------------------------------------------
                ),
                backgroundColor: Color.fromRGBO(30, 42, 51, 1.0),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),

              //--------------------------------------------------------
              // These are the routes of the different screens in the app
              routes: {
                FavoriteScreen.routeName: (ctx) => new FavoriteScreen(),
                ComparisonWidget.routeName: (ctx) => new ComparisonWidget(),
                SettingsScreen.routeName: (ctx) => new SettingsScreen(),
              },
              home: HomeScreen(),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
