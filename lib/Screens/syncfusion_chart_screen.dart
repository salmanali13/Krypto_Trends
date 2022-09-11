//-----------------------------------------------------------------
// This is the synfusion chart detail screen of single currency
//-----------------------------------------------------------------

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

//--------------------------------------------------
// These are internal library imports i.e. models and widgets.
//--------------------------------------------------
import '../models/Crypto_model.dart';
import '../widget/chart_container.dart';
import '../widget/currency_Properties.dart';

// ignore: must_be_immutable
class SyncfusionCartScreen extends StatefulWidget {
  final String name;
  final String price;
  String id;
  String selectedCurrencyName;

  var currency;

  SyncfusionCartScreen(
      this.name, this.price, this.id, this.selectedCurrencyName);

  @override
  _SyncfusionCartScreen createState() => _SyncfusionCartScreen();
}

class _SyncfusionCartScreen extends State<SyncfusionCartScreen> {
  @override
  void initState() {
    widget.currency = Provider.of<Curruncies>(context, listen: false)
        .curruncies
        .firstWhere((element) => element.id == widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //That is the chart container widget--------------------
              ChartContainer(
                widget.id,
                widget.name,
              ),

              SizedBox(height: 20),
              //This is the Currency Properties Widget----------------
              CurrencyPropertiesWidget(
                name: widget.id,
                price: widget.price,
                rank: widget.currency.rank,
                circulatingSupply: widget.currency.circulatingSupply,
                maxSupply: widget.currency.maxSupply,
                status: widget.currency.status,
                selectedCurrencyName: widget.selectedCurrencyName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
