import 'package:firebase_performance/firebase_performance.dart';

class FirebasePerformanceService {
  Trace traceBuilder(String name) {
    final Trace codeTimePerformance =
        FirebasePerformance.instance.newTrace("$name");
    return codeTimePerformance;
  }
}
