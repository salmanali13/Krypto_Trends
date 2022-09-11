//------------------------------------------------------------------------------
// This class calls the sparkline graph api and pares the fetched-data to
// the model class
//

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List<CryptoGraph> cryptoGraphFromJson(String str) => List<CryptoGraph>.from(
    json.decode(str).map((x) => CryptoGraph.fromJson(x)));

String cryptoGraphToJson(List<CryptoGraph> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CryptoGraph {
  CryptoGraph({
    this.currency,
    this.id,
    this.timestamps,
    this.prices,
  });

  final String currency;
  final String id;
  final List<DateTime> timestamps;
  final List<double> prices;

  factory CryptoGraph.fromJson(Map<String, dynamic> json) => CryptoGraph(
        currency: json["currency"],
        id: json["id"],
        timestamps: List<DateTime>.from(
            json["timestamps"].map((x) => DateTime.parse(x))),
        prices: List<double>.from(json["prices"].map((x) => double.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "id": id,
        "timestamps":
            List<dynamic>.from(timestamps.map((x) => x.toIso8601String())),
        "prices": List<double>.from(prices.map((x) => x)),
      };
}

class CryptoGraphsCurruncies with ChangeNotifier {
  List<CryptoGraph> _graphs = []; //initiallizing as null list

//---------------------------------------------------------------
// This returns the fetched sparkline data
  List<CryptoGraph> get graphs {
    return [..._graphs];
  }

//---------------------------------------------------------------
// This function calls the api to fetch data depending on the given
// Parameters
  Future<void> fetchingGraphData(
      String screen, String id, String label, String curruncy) async {
    String startingDate;
    //--------------This manipulates the dates to be sent to fetchData----------------
    switch (label) {
      case '1H':
        {
          startingDate = DateFormat('hh:mm:a')
              .format(DateTime.now().subtract(Duration(minutes: 59)));
        }
        break;

      case '1D':
        {
          startingDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(hours: 24)));
        }
        break;

      case '7D':
        {
          startingDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 7)));
        }
        break;

      case '1M':
        {
          startingDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 30)));
        }
        break;

      case '6M':
        {
          startingDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 180)));
        }
        break;

      case '1Y':
        {
          startingDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 365)));
        }
        break;

      case '3Y':
        {
          startingDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 1095)));
        }
        break;

      case '5Y':
        {
          startingDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 1825)));
        }
        break;
    }

    final endingDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // final startingDate = DateFormat('yyyy-MM-dd')
    //     .format(DateTime.now().subtract(Duration(days: 1095)));
    print(endingDate);
    final key = "8e83f6fb3c82cce5a20f29d29435d925";
    String url;
    if (screen == null) {
      url =
          "https://api.nomics.com/v1/currencies/sparkline?key=$key&ids=BTC,ETH,XRP,HEX,BNB,USDC,USDT,LTC&start=${startingDate}T02%3A00%3A00Z&end=${endingDate}T00%3A00%3A00Z&convert=$curruncy";
    } else {
      url =
          "https://api.nomics.com/v1/currencies/sparkline?key=$key&start=${startingDate}T02%3A00%3A00Z&end=${endingDate}T00%3A00%3A00Z&ids=$id&convert=$curruncy";
    }
    try {
      var response = await http.get(Uri.parse(url));
      final getdata = json.decode(response.body) as List<dynamic>;
      _graphs = getdata.map((data) => CryptoGraph.fromJson(data)).toList();
      // print('this is graphs length in api Call ${_graphs.length}');
      // print(_graphs.map((e) => e.prices));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

//---------------------------------------------------------------
// This class stores the data to be projected on the Syncfusion Chart Graph
class TrendsData {
  DateTime dateTimes;
  double prices;
  TrendsData(this.dateTimes, this.prices);

  static List<TrendsData> chartData(
      String labelOfChip, List<DateTime> dates, List<double> pricesList) {
    // print('this is length of dates : ${dates.length}');
    // print('this is length of prices : ${pricesList.length}');
    List<TrendsData> data = [];

    for (var i = 0; i < dates.length; i++) {
      data.add(TrendsData(dates[i], pricesList[i]));
    }
    // print(data..map((e) => e.dateTimes).length);
    return data;
  }
}
