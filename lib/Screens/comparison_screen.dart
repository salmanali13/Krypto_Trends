//-------------------------------------------------------------
//This widget shows the Graph and Choice chips below that Graph
//-------------------------------------------------------------

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:the_krypto_trends/services/firebase_performance.dart';

//------------------Internal Files imports--------------------
import '../widget/dateFormatBuilder.dart';
import '../models/Cyrpto_price_graph.dart';
import '../models/choice_chip.dart';
import '../models/curruncy_Converter.dart';
import '../widget/app_drawer.dart';
import '../widget/comparison_properties.dart';

// ignore: must_be_immutable
class ComparisonWidget extends StatefulWidget {
  static const routeName = '/comparison-screen';
  DateTime lastPressed = DateTime.now();

  String id = "ETH";
  String id2 = "BTC";

  bool init = true;
  bool initProp = true;
  String labelOfChip = '1M';
  int index;
  int index2;
  String dropdownValue = "BTC";
  String dropdownValue2 = "ETH";
  var fetchedList;
  var fetchedCurrencyMode;
  // ignore: non_constant_identifier_names
  String selected_currency;
  List<String> dropdownCurrencies = [
    'BTC',
    'ETH',
    'XRP',
    'USDC',
    'BNB',
    'HEX',
    'USDT',
    'LTC'
  ];

  @override
  _ComparisonWidgetState createState() => _ComparisonWidgetState();
}

class _ComparisonWidgetState extends State<ComparisonWidget> {
  List<ChoiceChipData> choiceChips = ChoiceChips.all;

  @override
  void initState() {
    final myTrace = FirebasePerformanceService()
        .traceBuilder("-Comparison Screen Loading trace-");
    myTrace.start();
    widget.selected_currency =
        Provider.of<ListOfCurruncies>(context, listen: false).curruncy_selected;

    Provider.of<CryptoGraphsCurruncies>(context, listen: false)
        .fetchingGraphData(
            null, null, widget.labelOfChip, widget.selected_currency)
        .then((value) {
      widget.init = false;
      widget.initProp = false;
    }).then((value) {
      widget.fetchedList =
          Provider.of<CryptoGraphsCurruncies>(context, listen: false).graphs;
      indexSwapping();
      myTrace.stop();
    });
    super.initState();
  }

  void indexSwapping() {
    widget.index =
        widget.fetchedList.indexWhere((item) => item.currency == widget.id);
    widget.index2 =
        widget.fetchedList.indexWhere((item) => item.currency == widget.id2);
  }

  @override
  Widget build(BuildContext context) {
    print("Index of Instance:  ${widget.index}");
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(widget.lastPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        widget.lastPressed = DateTime.now();
        if (isExitWarning) {
          Fluttertoast.showToast(msg: "Tap Again to Exit");
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
              builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(FontAwesomeIcons.alignLeft))),
          title: Text("Comparison"),
        ),
        drawer: AppDrawer(),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: SingleChildScrollView(
            child: Column(children: [
              //----------------------------------------------------------------
              //--------These Are the DropDown Lists----------------------------
              //----------------------------------------------------------------
              Container(
                constraints: BoxConstraints(
                  maxHeight: 50,
                  maxWidth: double.infinity,
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 4,
                          right: 4,
                        ),
                        height: 35,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(71, 96, 114, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: widget.id,
                            style: GoogleFonts.quicksand(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.blue,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
                              setState(() {
                                widget.id = newValue;
                                indexSwapping();
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return widget.dropdownCurrencies
                                  .map((String value) {
                                return Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    widget.id,
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.justify,
                                  ),
                                );
                              }).toList();
                            },
                            items: widget.dropdownCurrencies
                                .map<DropdownMenuItem<String>>(
                                    (String choosenValue) {
                              return DropdownMenuItem<String>(
                                value: choosenValue,
                                child: Text(choosenValue),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      //-----------------------------------------------------------
                      //--------------------------   2   --------------------------
                      //-----------------------------------------------------------
                      Container(
                        padding: EdgeInsets.only(
                          left: 4,
                          right: 4,
                        ),
                        height: 35,
                        // width: 70,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(71, 96, 114, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: widget.id2,
                            style: GoogleFonts.quicksand(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.redAccent,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
                              setState(() {
                                widget.id2 = newValue;
                                indexSwapping();
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return widget.dropdownCurrencies
                                  .map((String value) {
                                return Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    widget.id2,
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.justify,
                                  ),
                                );
                              }).toList();
                            },
                            items: widget.dropdownCurrencies
                                .map<DropdownMenuItem<String>>(
                                    (String choosenValue) {
                              return DropdownMenuItem<String>(
                                value: choosenValue,
                                child: Text(
                                  choosenValue,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ]),
              ),
              //-----------------------------------------------------------------------------------------
              //--------These Are the DropDown Lists-----------------------------------------------------
              //-----------------------------------------------------------------------------------------
              Consumer<CryptoGraphsCurruncies>(
                builder: (context, graph, _) => widget.init
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white38,
                        ),
                      )
                    : Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(13))),
                        color: Color.fromRGBO(35, 56, 70, 1.0),
                        margin: EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 4, right: 8, bottom: 2),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            //---------------------------------------
                            //This property make changes to X_Axis...
                            //---------------------------------------
                            primaryXAxis: DateTimeAxis(
                              maximumLabels: 7,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              axisLine: AxisLine(
                                width: 0.0,
                                color: Color.fromRGBO(35, 56, 70, 1.0),
                              ),
                              majorTickLines: MajorTickLines(width: 0.5),
                              majorGridLines: MajorGridLines(width: 0),
                              minorGridLines: MinorGridLines(width: 0),
                              labelStyle: TextStyle(
                                color: Colors.white54,
                              ),
                              dateFormat: dateFormatBuilder(widget.labelOfChip),
                              desiredIntervals: 6,
                              plotOffset: 5,
                            ),

                            //--------------------------------------------------
                            //This property make changes to Y_Axis...
                            //--------------------------------------------------

                            primaryYAxis: NumericAxis(
                              maximumLabels: 7,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              axisLine: AxisLine(
                                  width: 0.0,
                                  color: Color.fromRGBO(35, 56, 70, 1.0)),
                              majorTickLines: MajorTickLines(
                                  width: 0.5, color: Colors.white10),
                              majorGridLines: MajorGridLines(
                                  width: 0.5, color: Colors.white10),
                              labelStyle: TextStyle(
                                color: Colors.white54,
                              ),
                              numberFormat:
                                  NumberFormat.compact(locale: 'en_US'),
                            ),

                            legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              textStyle: TextStyle(color: Colors.white),
                            ),

                            trackballBehavior: TrackballBehavior(
                                markerSettings: TrackballMarkerSettings(
                                  borderWidth: 8.0,
                                  borderColor: Color.fromRGBO(30, 42, 51, 1.0),
                                  markerVisibility:
                                      TrackballVisibilityMode.visible,
                                ),
                                lineDashArray: [5, 5],
                                lineColor: Colors.white38.withOpacity(0.3),

                                //----------------------------------------------
                                // These are interactiveTooltip settings
                                //----------------------------------------------
                                tooltipSettings: InteractiveTooltip(
                                  borderColor: Colors.white60,
                                  borderWidth: 2,
                                  canShowMarker: true,

                                  enable: true,
                                  format: 'point.y',

                                  //----These are the decoration prpperties of Tooltip
                                  borderRadius: 8,
                                  color: Color.fromRGBO(30, 42, 51, 1.0),
                                ),
                                enable: true,
                                activationMode: ActivationMode.singleTap),
                            series: <ChartSeries>[
                              //----------------------------------------------
                              //---------The 1st series starts from here------
                              //----------------------------------------------
                              SplineSeries<TrendsData, DateTime>(
                                  legendIconType: LegendIconType.circle,
                                  name:
                                      "${graph.graphs[widget.index].currency}",
                                  enableTooltip: true,
                                  dataSource: TrendsData.chartData(
                                      widget.labelOfChip,
                                      graph.graphs[widget.index].timestamps,
                                      graph.graphs[widget.index].prices),
                                  xValueMapper: (TrendsData trends, _) =>
                                      trends.dateTimes,
                                  yValueMapper: (TrendsData trends, _) =>
                                      trends.prices),
                              //----------------------------------------------
                              //---------The 2nd series starts from here------
                              //----------------------------------------------
                              SplineSeries<TrendsData, DateTime>(
                                  color: Colors.redAccent,
                                  legendIconType: LegendIconType.circle,
                                  legendItemText:
                                      "${graph.graphs[widget.index2].currency}",
                                  enableTooltip: true,
                                  dataSource: TrendsData.chartData(
                                      widget.labelOfChip,
                                      graph.graphs[widget.index2].timestamps,
                                      graph.graphs[widget.index2].prices),
                                  xValueMapper: (TrendsData trends, _) =>
                                      trends.dateTimes,
                                  yValueMapper: (TrendsData trends, _) =>
                                      trends.prices),
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              //--------------------------------------------------------------------
              //--------------------------------------------------------------------
              //-------------THE CODE FOR CHOICE CHIP STARTS FROM HERE--------------
              //--------------------------------------------------------------------
              //--------------------------------------------------------------------
              FittedBox(
                  child: Wrap(
                spacing: 8.0,
                children: choiceChips
                    .map((choiceChip) => ChoiceChip(
                          label: Text(choiceChip.label),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: choiceChip.isSelected
                                  ? Colors.black
                                  : Colors.white),
                          onSelected: (isSelected) => setState(() {
                            choiceChips = choiceChips.map((otherChip) {
                              //---------Here we will triggr different Providers Depending upon the Chip-----------
                              widget.labelOfChip = choiceChip.label;
                              Provider.of<CryptoGraphsCurruncies>(context,
                                      listen: false)
                                  .fetchingGraphData(
                                      null,
                                      null,
                                      choiceChip.label,
                                      Provider.of<ListOfCurruncies>(context,
                                              listen: false)
                                          .curruncy_selected);

                              final newChip = otherChip.copy(isSelected: false);
                              return choiceChip == newChip
                                  ? newChip.copy(isSelected: isSelected)
                                  : newChip;
                            }).toList();
                          }),
                          selected: choiceChip.isSelected,
                          selectedColor: Colors.amber[700],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: choiceChip.isSelected
                                    ? Colors.amber[700]
                                    : Colors.white10,
                                width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //----------------------------------------------
                          //This is the unselected choice chip color
                          backgroundColor: Color.fromRGBO(30, 42, 51, 1.0),
                        ))
                    .toList(),
              )),
              SizedBox(
                height: 50,
              ),

              ComparisonPropWidget(
                id1: widget.id,
                id2: widget.id2,
                currencySelected: widget.selected_currency,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
