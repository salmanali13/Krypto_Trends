//---------------------------------------------------
// This widget shows the currency selection dialog
//---------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//---------------------------------------------------
import '../models/curruncy_Converter.dart';
import '../Screens/home_screen.dart';

class CurrencyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> showCurrencyDialog(BuildContext context) async {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              backgroundColor: Color.fromRGBO(35, 56, 70, 1.0),
              title: Text(
                "Select Curruncy",
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                ),
              ),
              content: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(0),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    radius: Radius.circular(5),
                    thickness: 2,
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        buildCurrencyTile(
                            context, "American Dollar", "USD", 0),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "Euro", "EUR", 1),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Great Britian Pound", "GBP", 2),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Australian Dollar", "AUD", 3),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Pakistani Rupees", "PKR", 4),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "Japanese YEN", "JPY", 5),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "Indian Rupees", "INR", 6),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "UAE Dirham", "AED", 7),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Brazilian Real", "BRL", 8),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Canadian Dollar", "CAD", 9),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "WIR Euro", "CHE", 10),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "New Israeli Sheqel", "ILS", 11),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Iceland Krona", "ISK", 12),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Kuwaiti Dinar", "KWD", 13),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "Rial Omani", "OMR", 14),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Bahraini Dinar", "BHD", 15),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "Zloty", "PLN", 16),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "Qatari Rial", "QAR", 17),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Russian Ruble", "RUB", 18),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "Saudi Riyal", "SAR", 19),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Swedish Krona", "SEK", 20),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(
                            context, "Singapore Dollar", "SGD", 21),
                        Divider(
                          color: Colors.white38,
                        ),
                        buildCurrencyTile(context, "Turkish Lira", "TRY", 22),
                        Divider(
                          color: Colors.white38,
                        ),
                      ],
                    ),
                  )),
            );
          });
    }

    return IconButton(
        onPressed: () {
          showCurrencyDialog(context);
        },
        icon: Icon(
          Icons.change_circle_outlined,
          size: 28,
        ));
  }

  ListTile buildCurrencyTile(
      BuildContext context, String name, String id, int index) {
    return ListTile(
      leading: Text(
        name,
      ),
      trailing: Text(id, style: TextStyle(color: Colors.white54)),
      onTap: () =>
          onTapCurrencyChange(context, index, "All prices Converted to $id"),
    );
  }
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
void onTapCurrencyChange(
  BuildContext context,
  int index,
  String msg,
) {
  print(" this is Currency Index:  $index");
  Provider.of<ListOfCurruncies>(context, listen: false)
      .curruncySelection(index);

  Fluttertoast.showToast(
    msg: msg,
    webPosition: "center",
    webBgColor: "Colors.black",
    textColor: Colors.black87,
    backgroundColor: Colors.white.withOpacity(0.9),
    timeInSecForIosWeb: 1,
  ).then((value) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (ctx) => HomeScreen(),
    ));
  });
}
