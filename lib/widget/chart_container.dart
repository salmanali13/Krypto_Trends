//-------------------------------------------------------------
//This widget shows the Graph and Choice chips in "crypto detail screen"
//-------------------------------------------------------------

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../services/firebase_performance.dart';

//------------------Internal Files imports--------------------
import '../models/curruncy_Converter.dart';
import '../models/Cyrpto_price_graph.dart';
import '../models/choice_chip.dart';
import 'dateFormatBuilder.dart';

// ignore: must_be_immutable
class ChartContainer extends StatefulWidget {
  ChartContainer(this.id, this.name);
  String id;
  final String name;
  bool init = true;
  String labelOfChip = '1M';
  int index;

  @override
  _ChartContainerState createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  List<ChoiceChipData> choiceChips = ChoiceChips.all;

  @override
  void initState() {
    final myTrace = FirebasePerformanceService()
        .traceBuilder("-Detail Screen Graph Loading trace-");
    myTrace.start();
    Provider.of<CryptoGraphsCurruncies>(context, listen: false)
        .fetchingGraphData(
            "singleId",
            widget.id,
            widget.labelOfChip,
            Provider.of<ListOfCurruncies>(context, listen: false)
                .curruncy_selected)
        .then((value) => widget.init = false)
        .then((value) {
      var fetchedList =
          Provider.of<CryptoGraphsCurruncies>(context, listen: false).graphs;
      widget.index =
          fetchedList.indexWhere((item) => item.currency == widget.id);
      myTrace.stop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("This is Required ID: ${widget.name}");
    print("Index of Instance:  ${widget.index}");
    return Container(
        height: 415,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Column(children: [
          Consumer<CryptoGraphsCurruncies>(
              builder: (context, graph, _) => widget.init
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white38,
                      ),
                    )
                  : AnimatedOpacity(
                      duration: Duration(milliseconds: 1000),
                      opacity: widget.init ? 0.0 : 1,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(13))),
                        color: Color.fromRGBO(35, 56, 70, 1.0),
                        margin: EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SfCartesianChart(
                            // backgroundColor: Color.fromRGBO(35, 56, 70, 0.5),
                            plotAreaBorderWidth: 0,

                            //--------------------------------------------------
                            //This property make changes to X_Axis...
                            //--------------------------------------------------
                            primaryXAxis: DateTimeAxis(
                              maximumLabels: 7,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              axisLine: AxisLine(
                                  width: 0.0,
                                  color: Color.fromRGBO(35, 56, 70, 1.0)),
                              majorTickLines: MajorTickLines(width: 0.5),
                              majorGridLines: MajorGridLines(width: 0),
                              minorGridLines: MinorGridLines(width: 0),
                              labelStyle: TextStyle(
                                color: Colors.white54,
                              ),
                              labelAlignment: LabelAlignment.center,
                              rangePadding: ChartRangePadding.normal,
                              dateFormat: dateFormatBuilder(widget.labelOfChip),
                              // interval: 5,
                              desiredIntervals: 6,
                              plotOffset: 5,
                            ),
                            //--------------------------------------------------
                            //This property make changes to Y_Axis...
                            //--------------------------------------------------
                            primaryYAxis: NumericAxis(
                              maximumLabels: 7,
                              axisLine: AxisLine(
                                width: 0.0,
                              ),
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

                            trackballBehavior: TrackballBehavior(
                                markerSettings: TrackballMarkerSettings(
                                  color: Colors.amber[700],
                                  borderWidth: 8.0,
                                  borderColor: Color.fromRGBO(30, 42, 51, 1.0),
                                  markerVisibility:
                                      TrackballVisibilityMode.visible,
                                ),
                                lineColor: Colors.amber[700].withOpacity(0.3),
                                tooltipSettings: InteractiveTooltip(
                                  borderColor: Colors.white60,
                                  canShowMarker: false,
                                  borderWidth: 2,
                                  enable: true,
                                  format: 'point.x \n point.y',

                                  //----These are the decoration prpperties-----
                                  borderRadius: 8,
                                  color: Color.fromRGBO(30, 42, 51, 1.0),
                                ),
                                enable: true,
                                activationMode: ActivationMode.singleTap),
                            //  title: ChartTitle(
                            //     text: '${widget.name}',
                            // textStyle: TextStyle(color: Colors.white)),

                            series: <ChartSeries>[
                              SplineAreaSeries<TrendsData, DateTime>(
                                  borderColor: Colors.amber[700],
                                  color: Colors.white60,
                                  borderWidth: 2,
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Colors.amber[700].withOpacity(0.2),
                                      Colors.amber[700].withOpacity(0.1),
                                      Colors.transparent,
                                    ],
                                    stops: <double>[0.3, 0.5, 0.9],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  enableTooltip: true,
                                  dataSource: TrendsData.chartData(
                                      widget.labelOfChip,
                                      graph.graphs[widget.index].timestamps,
                                      graph.graphs[widget.index].prices),
                                  xValueMapper: (TrendsData trends, _) =>
                                      trends.dateTimes,
                                  // DateFormat.MMMd()
                                  //     .format(trends.dateTimes),
                                  yValueMapper: (TrendsData trends, _) =>
                                      trends.prices)
                            ],
                          ),
                        ),
                      ),
                    )),
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
                  .map(
                    (choiceChip) => ChoiceChip(
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
                                  "singleId",
                                  widget.id,
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
                      // selectedColor: Color.fromRGBO(71, 96, 114, 1),
                      selectedColor: Colors.amber[700],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: choiceChip.isSelected
                                ? Colors.amber[700]
                                : Colors.white10,
                            width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledColor: Color.fromRGBO(30, 42, 51, 0.5),
                      backgroundColor: Color.fromRGBO(30, 42, 51, 1.0),
                    ),
                  )
                  .toList(),
            ),
          ),
        ]));
  }
}
