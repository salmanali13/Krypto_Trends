//------------------------------------------------------------------------------
// This is the model and business logic class of fetched crypto currencies

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//---------------------------------------------------------------
// This is the model class that is used to parse fetched currencies data
// into a model
class CryptoData with ChangeNotifier {
  CryptoData cryptoDataFromJson(String str) =>
      CryptoData.fromJson(json.decode(str));

  String cryptoDataToJson(CryptoData data) => json.encode(data.toJson());

  CryptoData(
      {this.currency,
      this.id,
      this.status,
      this.price,
      this.priceDate,
      this.priceTimestamp,
      this.symbol,
      this.logoUrl,
      this.circulatingSupply,
      this.maxSupply,
      this.name,
      this.rank,
      this.iD});

  String currency = '';
  String id;
  String status;
  String price;
  DateTime priceDate;
  DateTime priceTimestamp;
  String symbol;
  String logoUrl;
  String circulatingSupply;
  String maxSupply;
  String name;
  String rank;
  The1D iD;

  factory CryptoData.fromJson(Map<String, dynamic> json) {
    return CryptoData(
      currency: json["currency"],
      id: json["id"],
      status: json["status"],
      price: json["price"],
      priceDate: DateTime.parse(json["price_date"]),
      priceTimestamp: DateTime.parse(json["price_timestamp"]),
      symbol: json["symbol"],
      logoUrl: json["logo_url"],
      circulatingSupply: json["circulating_supply"],
      maxSupply: json["max_supply"],
      name: json["name"],
      rank: json["rank"],
      iD: The1D.fromJson(json["1d"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "currency": currency,
        "id": id,
        "status": status,
        "price": price,
        "price_date": priceDate.toIso8601String(),
        "price_timestamp": priceTimestamp.toIso8601String(),
        "symbol": symbol,
        "logo_url": logoUrl,
        "circulating_supply": circulatingSupply,
        "max_supply": maxSupply,
        "name": name,
        "rank": rank,
        "1d": iD.toJson(),
      };
}

class The1D {
  The1D({
    this.priceChange,
    this.priceChangePct,
    this.volume,
  });

  String priceChange;
  String priceChangePct;
  String volume;

  factory The1D.fromJson(Map<String, dynamic> json) => The1D(
        priceChange: json["price_change"],
        priceChangePct: json["price_change_pct"],
        volume: json["volume"],
      );

  Map<String, dynamic> toJson() => {
        "price_change": priceChange,
        "price_change_pct": priceChangePct,
        "volume": volume,
      };
}

class Curruncies with ChangeNotifier {
  List<CryptoData> curruncies = [];

//-------------------------------------------------------------
// ...This is the getter that returns list of curruncies...
  List<CryptoData> get currunciesList {
    return [...curruncies];
  }

  //

  // ...This function fetches currency data and saves the fetched map in our model...
  Future<void> fetchingData(String selectedCurruncy) async {
    final key = "8e83f6fb3c82cce5a20f29d29435d925";
    var url =
        "https://api.nomics.com/v1/currencies/ticker?key=$key&convert=$selectedCurruncy&per-page=40&page=1&sort=rank";

    try {
      var response = await http.get(Uri.parse(url));
      final getdata = json.decode(response.body) as List<dynamic>;

      curruncies = getdata.map((data) => CryptoData.fromJson(data)).toList();

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  double parseToDouble(String id) {
    // notifyListeners();
    return parseToDouble(
        currunciesList.firstWhere((curruncy) => curruncy.id == id).price);
  }
}
