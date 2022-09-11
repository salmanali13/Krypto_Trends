//------------------------------------------------------------
//This widget shows the currency properties in detailed screen
//------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyPropertiesWidget extends StatelessWidget {
  const CurrencyPropertiesWidget({
    Key key,
    @required this.name,
    @required this.price,
    @required this.rank,
    @required this.circulatingSupply,
    @required this.maxSupply,
    @required this.status,
    @required this.selectedCurrencyName,
  }) : super(key: key);

  final String name;
  final String price;
  final String rank;
  final String circulatingSupply;
  final String maxSupply;
  final String status;
  final String selectedCurrencyName;

  @override
  Widget build(BuildContext context) {
    final priceParsed = NumberFormat().format(double.parse(price));
    print(
        "------------------This is Currency Properties widget------------------");
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13))),
      color: Color.fromRGBO(35, 56, 70, 1.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$name : ",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  NumberFormat.simpleCurrency(name: "$selectedCurrencyName")
                      .currencySymbol,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                Text(
                  " $priceParsed",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.3,
              indent: 60,
              endIndent: 60,
            ),
            Row(
              children: [
                Text(
                  'Rank',
                ),
                Spacer(),
                Text(
                  '$rank',
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 0.3),
            Row(
              children: [
                Text(
                  'Circulating Supply',
                ),
                Spacer(),
                Text(
                  '$circulatingSupply',
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 0.3),
            Row(
              children: [
                Text(
                  'Max Supply',
                ),
                Spacer(),
                Text(
                  '$maxSupply',
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 0.3),
            Row(
              children: [
                Text(
                  'Current Status ',
                ),
                Spacer(),
                Text(
                  '$status',
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 0.3),
            Row(
              children: [
                Text(
                  'Price Date',
                ),
                Spacer(),
                Text(
                  '${DateFormat.yMd().format(DateTime.now())}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
