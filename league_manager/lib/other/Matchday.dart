import 'package:league_manager/other/Match.dart';

class Matchday {
  final int dayNumber;
  final List<Match> matches;

  Matchday(this.dayNumber, this.matches);

  @override
  String toString() {
    return 'Matchday $dayNumber: $matches';
  }
}