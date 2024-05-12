import 'package:league_manager/other/Match.dart';

class Matchday {
  final int dayNumber;
  final List<Match> matches;

  Matchday(this.dayNumber, this.matches);

  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'matches': matches.map((match) => match.toJson()).toList(),
    };
  }

  // fromJson method to convert JSON to Matchday object
  factory Matchday.fromJson(Map<String, dynamic> json) {
    return Matchday(
      json['dayNumber'],
      List<Match>.from(json['matches'].map((matchJson) => Match.fromJson(matchJson))),
    );
  }

  @override
  String toString() {
    return 'Matchday $dayNumber: $matches';
  }
}