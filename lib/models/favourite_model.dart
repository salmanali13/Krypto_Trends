//------------------------------------------------------------------------
// This is favourite ist model class with model and all the business logic
//------------------------------------------------------------------------
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

//------------------------------------------------------------------------
// This is the Model class
//------------------------------------------------------------------------
class FavouriteStatus with ChangeNotifier {
  String id;
  String price;
  bool isFavourite;

  FavouriteStatus({
    this.id,
    this.isFavourite,
    this.price,
  });

  factory FavouriteStatus.fromJson(Map<String, dynamic> json) {
    return FavouriteStatus(
      id: json["id"],
      isFavourite: json["isFavourite"],
      price: json["price"],
    );
  }

  Map<String, Object> toJson() => {
        "id": id,
        "isFavourite": isFavourite,
        "price": price,
      };
}

//------------------------------------------------------------------------
// This is business logic class
class Favourites with ChangeNotifier {
  List<FavouriteStatus> _favourites = [];
//-----------------------------------------------------------------------
//--------This method is called while initiallizing gett Favourites------

  Future<bool> declarePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("favouritesData") == true) {
      print("--------Control is in DECLARE PREFS method---------");
      final getdata = json.decode(prefs.getString('favouritesData')) as List;
      print(getdata.length);
      _favourites = getdata
          .map((favouritesData) => FavouriteStatus.fromJson(favouritesData))
          .toList();
      print("Data Returned");
      return true;
    } else {
      print("Nothing is Returned");
      return false;
    }
  }

//------------------------------------------------------------------------------
//-----------This method is called at the end of the Toggle favourite method----
  Future<void> savingPrefs(String favouritesData) async {
    final prefs = await SharedPreferences.getInstance();
    print("this is length : ${favouritesData.length}");
    prefs.setString('favouritesData', favouritesData);
  }

//---------------------------------------------------------------
// This getter returns the favourites list that is locally stored
  List<FavouriteStatus> get favourites {
    return [..._favourites];
  }

//---------------------------------------------------------------
// This funtions returns the boolean value that tells whether a currency is favourited or not
  bool returnFavouriteStatus(String id) {
    return _favourites.any((item) => item.id == id);
  }

//---------------------------------------------------------------
// This function toggles the favourite status and updates the favourites
// list in the shared preferences
//---------------------------------------------------------------
  void toggleFavouriteStatus(String id, String price) {
    int i = _favourites.indexWhere((item) => item.id == id);
    //-----------------------------------------------------------
    // Here we are Toggling the value of isfavourite
    //-----------------------------------------------------------
    if (i >= 0) {
      _favourites.removeAt(i);
      notifyListeners();
    } else {
      _favourites.add(FavouriteStatus(
        id: id,
        isFavourite: true,
        price: price,
      ));
      notifyListeners();
    }

    String favouritesData =
        jsonEncode(_favourites.map((item) => item.toJson()).toList())
            .toString();

    savingPrefs(favouritesData);
  }
}
