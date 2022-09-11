//-----------------------------------------------------------
// This file formats the "DATE Format" in the detailed graph
// screen corresponding to the "choicechips" selection
//-----------------------------------------------------------

import 'package:intl/intl.dart';

DateFormat dateFormatBuilder(String labelofChip) {
  DateFormat _format;
  switch (labelofChip) {
    case '1H':
      {
        _format = DateFormat.Hms();
      }
      break;

    case '1D':
      {
        _format = DateFormat("HH:mm");
      }
      break;

    case '7D':
      {
        _format = DateFormat.E();
      }
      break;

    case '1M':
      {
        _format = DateFormat.MMMd();
      }
      break;

    case '6M':
      {
        _format = DateFormat.MMMd();
      }
      break;

    case '1Y':
      {
        _format = DateFormat.MMM();
      }
      break;

    case '3Y':
      {
        _format = DateFormat.yMMM();
      }
      break;

    case '5Y':
      {
        _format = DateFormat.yMMM();
      }
      break;
  }

  return _format;
}
