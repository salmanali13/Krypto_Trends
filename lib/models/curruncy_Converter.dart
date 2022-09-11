//------------------------------------------------------------------------------
// This is the model and business logic class of the conversion currencies

import 'package:flutter/foundation.dart';

//---------------------------------------------------------------
// This is the model
class Curruncy {
  String name;

  Curruncy(this.name);
}

//---------------------------------------------------------------
// This is the business logic class
class ListOfCurruncies with ChangeNotifier {
  List<Curruncy> converter = [
    Curruncy("USD"), //0
    Curruncy("EUR"), //1
    Curruncy("GBP"), //2
    Curruncy("AUD"), //3
    Curruncy("PKR"), //4
    Curruncy("JPY"), //5
    Curruncy("INR"), //6
    Curruncy("AED"), //7
    Curruncy("BRL"), //8
    Curruncy("CAD"), //9
    Curruncy("CHE"), //10
    Curruncy("ILS"), //11
    Curruncy("ISK"), //12
    Curruncy("KWD"), //13
    Curruncy("OMR"), //14
    Curruncy("BHD"), //15
    Curruncy("PLN"), //16
    Curruncy("QAR"), //17
    Curruncy("RUB"), //18
    Curruncy("SAR"), //19
    Curruncy("SEK"), //20
    Curruncy("SGD"), //21
    Curruncy("TRY"), //22
  ];
  String globalCurruncy =
      "USD"; // This will be the curruncy selected by Default

//---------------------------------------------------------------
//This function is called to change the selection of the Curruncy
  void curruncySelection(int i) {
    if (i >= 0) {
      globalCurruncy = converter[i].name;
    } else {
      globalCurruncy = converter[0].name;
    }
    notifyListeners();
    print("Selected Curruncy is $globalCurruncy");
    // return globalCurruncy;
  }

//---------------------------------------------------------------
// This returns the selected currency in the whole app
  // ignore: non_constant_identifier_names
  String get curruncy_selected {
    return globalCurruncy;
  }
}
