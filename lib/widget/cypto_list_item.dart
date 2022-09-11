//----------------------------------------------------------
// This widget shows the single list item on the Home Screen
//----------------------------------------------------------

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'model_methods.dart';

//--------------------------------------------------------
//This Import shows SyncFusion Chart......................
//--------------------------------------------------------
import '../models/curruncy_Converter.dart';
import '../models/favourite_model.dart';
import '../Screens/syncfusion_chart_screen.dart';
import '../models/Crypto_model.dart';

var parsedPrice;

class CryptoListItem extends StatelessWidget {
  final String iD;
  final String name;
  final String imgURL;
  final String price;
  final String id;
  final String selectedCurrency;

  CryptoListItem(this.iD, this.name, this.price, this.id, this.imgURL,
      this.selectedCurrency);

//--------------------------------------------------------//
//---------------- Parse The "Price" String to Double-------------------//
//--------------------------------------------------------//
  double _parseToDouble() {
    return parsedPrice = double.parse(price);
  }

//--------------------------------------------------------//
//------------Changes the Icon of the Curruncy------------//
//--------------------------------------------------------//

//---------------------------------------------------------------------
//This function parses precentage into double and changes color depending upon value
  Widget parseAndColor() {
    final percentage = double.parse(iD);
    if (percentage >= 0) {
      return Text("+$percentage %", style: TextStyle(color: Colors.green));
    } else {
      return Text("$percentage %", style: TextStyle(color: Colors.red));
    }
  }
//---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    Widget svgPictureNetwork;
    svgPictureNetwork = pngOrsvg(svgPictureNetwork, imgURL);

    print("This is Crypto List Item Widget");
    print(iD);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      margin: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 8,
      ),
      color: Color.fromRGBO(35, 56, 70, 1.0),
      elevation: 3,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) =>
                  SyncfusionCartScreen(name, price, id, selectedCurrency),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        leading: svgPictureNetwork,
        title: Text(
          name,
        ),
        subtitle: parseAndColor(),
        trailing: Consumer3<Favourites, ListOfCurruncies, Curruncies>(builder:
            (context, favouritesProvider, currunciesProvider, currunciesData,
                _) {
          return Container(
            width: 133,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    NumberFormat.simpleCurrency(name: "$selectedCurrency")
                        .currencySymbol,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    " ${NumberFormat.compact(locale: 'en_US').format(_parseToDouble())}",
                    style: TextStyle(
                      fontSize: 16,
                      textBaseline: TextBaseline.alphabetic,
                      color: Colors.white54,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  IconButton(
                      icon: favouritesProvider.returnFavouriteStatus(
                              id) //this returns the favourite iconButton status upon tapping
                          ? Icon(
                              Icons.favorite,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white10,
                            ),
                      onPressed: () {
                        favouritesProvider.toggleFavouriteStatus(id, price);
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(
                          webShowClose: true,
                          msg: favouritesProvider.returnFavouriteStatus(id)
                              ? "Added in Favourites"
                              : "Removed from Favourites",
                          webPosition: "center",
                          textColor: Colors.black87,
                          backgroundColor: Colors.white.withOpacity(0.9),
                          timeInSecForIosWeb: 1,
                        );
                      })
                ]),
          );
        }),
      ),
    );
  }
}
