//------------------------------------------------------------------
// This Widget shows the comparison screen properties under the graph
//------------------------------------------------------------------

//--------------------------------------------------
// These are library imports and packages imports
//--------------------------------------------------
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

//--------------------------------------------------
// These are internal library imports
//--------------------------------------------------
import '/widget/model_methods.dart';
import '../models/Crypto_model.dart';

// ignore: must_be_immutable
class ComparisonPropWidget extends StatefulWidget {
  String id1;
  String id2;
  var currencySelected;

  CryptoData data1;
  CryptoData data2;
  var fetchedDataList;
  bool inIt = true;

  ComparisonPropWidget({
    this.id1,
    this.id2,
    this.currencySelected,
  });

  @override
  _ComparisonPropWidgetState createState() => _ComparisonPropWidgetState();
}

class _ComparisonPropWidgetState extends State<ComparisonPropWidget> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1))
        .then((value) => Provider.of<Curruncies>(context, listen: false)
            .fetchingData(widget.currencySelected))
        .then((value) {
      widget.fetchedDataList =
          Provider.of<Curruncies>(context, listen: false).currunciesList;
      getPropertiesbyId();
      widget.inIt = false;

      debugPrint(
          "-------------------is INIT STATE function--------------------");
    });

    super.initState();
  }
//--------------------------------------------------------
//--------------------------------------------------------
// Upon changning of currency selection we have to
// call the model again to fetch CurrencyList
// To achieve this we are required to put it all
// ------------in DidUpdateWidget--------------
//--------------------------------------------------------

  @override
  void didUpdateWidget(ComparisonPropWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (oldWidget.id1 != widget.id1 || oldWidget.id2 != widget.id2)

    widget.fetchedDataList =
        Provider.of<Curruncies>(context, listen: false).currunciesList;
    getPropertiesbyId();

    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        widget.inIt = false;
      });
    });
    debugPrint("-------------In DidUpdateWidget method-----------");
  }

  getPropertiesbyId() {
    widget.data1 = widget.fetchedDataList
        .firstWhere((item) => item.currency == widget.id1);
    widget.data2 = widget.fetchedDataList
        .firstWhere((item) => item.currency == widget.id2);
  }

  String extensionChecking(String logoUrl) {
    String extnsn = p.extension(logoUrl);
    return extnsn;
  }

  @override
  Widget build(BuildContext context) {
    print("...In Properties widget...");
    print("Value of inIT is :  ${widget.inIt}");
    // getPropertiesbyId();
    return Consumer<Curruncies>(
      builder: (_, curruncy, ch) => widget.inIt
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromRGBO(35, 56, 70, 1.0),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 30, left: 10, right: 10, bottom: 5),
                      child: Column(
                        children: [
                          propertyBuilder(
                              NumberFormat.simpleCurrency(
                                      decimalDigits: 1,
                                      name: widget.currencySelected)
                                  .format(double.parse(widget.data1.price)),
                              "Price",
                              NumberFormat.simpleCurrency(
                                      decimalDigits: 1,
                                      name: widget.currencySelected)
                                  .format(double.parse(widget.data2.price))),
                          Divider(
                            // indent: 2,
                            // endIndent: 2,
                            color: Colors.grey,
                          ),
                          propertyBuilder(
                              widget.data1.rank, "Rank", widget.data2.rank),
                          Divider(
                            // indent: 2,
                            // endIndent: 2,
                            color: Colors.grey,
                          ),
                          propertyBuilder(widget.data1.maxSupply, "Max-Supply",
                              widget.data2.maxSupply),
                          Divider(
                            color: Colors.grey,
                          ),
                          propertyBuilder(widget.data1.circulatingSupply,
                              "Circ-Supply", widget.data2.circulatingSupply),
                          Divider(
                            color: Colors.grey,
                          ),
                          propertyBuilder(widget.data1.status, "Status",
                              widget.data2.status),
                        ],
                      ),
                    ),
                  ),
                  imageBuilder(context, widget.data1.logoUrl, "left"),
                  imageBuilder(context, widget.data2.logoUrl, "right"),
                ],
              ),
            ),
    );
  }

  Row propertyBuilder(String value1, String name, String value2) {
    // var toDouble = double.parse('1.1');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            "$value1",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Text(
            '$name',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            "$value2",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Positioned imageBuilder(BuildContext context, String img, String side) {
    Widget pngOrSvg;
    Widget consTantWidget = Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: side == "left" ? Colors.blue : Colors.redAccent,
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        clipBehavior: Clip.antiAlias,
        child: pngOrsvg(pngOrSvg, img),
      ),
    );

    if (side == "left") {
      return Positioned(
        top: -30.0,
        left: MediaQuery.of(context).size.width * 0.12,
        height: 45,
        width: 45,
        child: consTantWidget,
      );
    } else {
      return Positioned(
        top: -30.0,
        right: MediaQuery.of(context).size.width * 0.12,
        height: 45,
        width: 45,
        child: consTantWidget,
      );
    }
  }
}
