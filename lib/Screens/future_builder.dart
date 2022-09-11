//-----------------------------------------------------------
// This screen checks network connectivity and builds list of crypto currencies
//-----------------------------------------------------------

//External Imports-------------------------------
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// Packages used---------------------------------
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../services/firebase_performance.dart';

//Internal Imports-------------------------------
import '../models/curruncy_Converter.dart';
import '../models/Crypto_model.dart';
import '../widget/cypto_list_item.dart';

// ignore: must_be_immutable
class FutureBuilderScreen extends StatefulWidget {
  bool isSearchOpen;
  FutureBuilderScreen(this.isSearchOpen);
  @override
  _FutureBuilderScreenState createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen>
    with SingleTickerProviderStateMixin {
  var isInit = true;
  var isLoading = true;
  String selectedCurrency;

  ConnectivityResult _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

// Disposes of the subscription variable upon disposing of this Widget----------
  @override
  void dispose() {
    _connectivitySubscription.cancel();

    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Future<void> _onrefreshIndicator(BuildContext context) async {
    final myTrace = FirebasePerformanceService()
        .traceBuilder("-Home Screen List Loading trace-");
    await myTrace.start();
    selectedCurrency =
        Provider.of<ListOfCurruncies>(context, listen: false).curruncy_selected;
    print(selectedCurrency);
    await Provider.of<Curruncies>(context, listen: false)
        .fetchingData(selectedCurrency)
        .then((value) {
      isLoading = false;
    });
    await myTrace.stop();
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    bool network;
    if (_connectionStatus == ConnectivityResult.mobile ||
        _connectionStatus == ConnectivityResult.wifi) {
      network = true;
    } else {
      network = false;
    }

    return SafeArea(
      maintainBottomViewPadding: true,
      child: network == false
          ? AnimatedContainer(
              duration: Duration(seconds: 5),
              alignment: Alignment.topCenter,
              height: network == false ? 20 : 0,
              color: Colors.redAccent,
              child: Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.white),
              ),
            )
          : FutureBuilder(
              future: _onrefreshIndicator(context),
              builder: (context, snapshot) => snapshot ==
                      AsyncSnapshot.waiting()
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white38,
                      ),
                    )
                  : Column(children: [
                      RefreshIndicator(
                        color: Colors.amber,
                        onRefresh: () => _onrefreshIndicator(context),
                        child: Consumer<Curruncies>(
                          builder: (ctx, curruncies, _) => Container(
                            height: (MediaQuery.of(context).size.height * 0.88),
                            child: AnimationLimiter(
                              child: ListView.builder(
                                itemBuilder: (_, i) =>
                                    AnimationConfiguration.staggeredList(
                                  position: i,
                                  duration: const Duration(milliseconds: 300),
                                  child: SlideAnimation(
                                    verticalOffset: 60.0,
                                    child: FadeInAnimation(
                                      child: CryptoListItem(
                                        curruncies.currunciesList[i].iD
                                            .priceChangePct,
                                        curruncies.currunciesList[i].name,
                                        curruncies.currunciesList[i].price,
                                        curruncies.currunciesList[i].id,
                                        curruncies.currunciesList[i].logoUrl,
                                        selectedCurrency,
                                      ),
                                    ),
                                  ),
                                ),
                                scrollDirection: Axis.vertical,
                                dragStartBehavior: DragStartBehavior.start,
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: curruncies.currunciesList.length,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
            ),
    );
  }
}
