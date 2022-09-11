//----------------------------------------------------------
// THis widget shows the single list item on the Home Screen
//----------------------------------------------------------

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//--------------------------------------------------------
//This Import shows simple SparkLine Chart................
//--------------------------------------------------------
import '../Screens/syncfusion_chart_screen.dart';

//--------------------------------------------------------
//This Import shows SyncFusion Chart......................
//--------------------------------------------------------

import '../models/Crypto_model.dart';
import '../models/curruncy_Converter.dart';
import 'model_methods.dart';

// ignore: must_be_immutable
class FavouriteListItem extends StatelessWidget {
  String id;
  String imgURL;
  bool favouriteStatus;
  String name;
  double parsedPrice;
  String selectedCurrency;

  FavouriteListItem(
    this.id,
    this.favouriteStatus,
    this.name,
  );
//---------------------------------------------------------------------
//This function parse price to double
  double _parseToDouble(String price) {
    return parsedPrice = double.parse(price);
  }

//---------------------------------------------------------------------
//This function parse precentage into double and changes color depending upon value
  Widget parseAndColor(String changPct) {
    final percentage = double.parse(changPct);
    if (percentage >= 0) {
      return Text("+$percentage %", style: TextStyle(color: Colors.green));
    } else {
      return Text("$percentage %", style: TextStyle(color: Colors.red));
    }
  }

//--------------Fetches SelectedCurrency and Set Icon accordingly
  void whichCurruncy(BuildContext ctx) {
    selectedCurrency =
        Provider.of<ListOfCurruncies>(ctx, listen: false).curruncy_selected;
  }

  @override
  Widget build(BuildContext context) {
    final currunciesList =
        Provider.of<Curruncies>(context, listen: false).currunciesList;
    final curruncyPrice =
        currunciesList[currunciesList.indexWhere((item) => item.currency == id)]
            .price;
    imgURL =
        currunciesList[currunciesList.indexWhere((item) => item.currency == id)]
            .logoUrl;
    final changPct =
        currunciesList[currunciesList.indexWhere((item) => item.currency == id)]
            .iD
            .priceChangePct;

    Widget svgPictureNetwork;
    svgPictureNetwork = pngOrsvg(svgPictureNetwork, imgURL);
    final _currencyPrice =
        NumberFormat.compact().format(_parseToDouble(curruncyPrice));
    whichCurruncy(context);

    print(imgURL);
    print("This is Id of Currency : $id");
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
              builder: (c) => SyncfusionCartScreen(
                  name, curruncyPrice, id, selectedCurrency),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        leading: Container(
          constraints: BoxConstraints(
            maxHeight: 40,
            maxWidth: 40,
          ),
          child: svgPictureNetwork,
        ),
        title: Text(
          id,
          style: TextStyle(color: Colors.white54),
        ),
        subtitle: parseAndColor(changPct),
        trailing: Container(
          width: 130,
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
                  " $_currencyPrice",
                  style: TextStyle(
                    fontSize: 16,
                    textBaseline: TextBaseline.alphabetic,
                    color: Colors.white54,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
