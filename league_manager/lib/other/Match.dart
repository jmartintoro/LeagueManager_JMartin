import 'package:league_manager/other/Team.dart';

class Match {
  Team homeTeam;
  int homeGoals;
  Team awayTeam;
  int awayGoals;

  Match(Team homeTeam, Team awayTeam)
      : homeTeam = homeTeam,
        homeGoals = 0,
        awayTeam = awayTeam,
        awayGoals = 0;

  Map<String, dynamic> toJson() {
    return {
      'homeTeam': homeTeam.toJson(),
      'homeGoals': homeGoals,
      'awayTeam': awayTeam.toJson(),
      'awayGoals': awayGoals,
    };
  }

  // fromJson method to convert JSON to Match object
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      Team.fromJson(json['homeTeam']),
      Team.fromJson(json['awayTeam']),
    )
      ..homeGoals = json['homeGoals']
      ..awayGoals = json['awayGoals'];
  }

  @override
  String toString() {
    return '${homeTeam.name} : ${homeGoals.toString()} vs ${awayTeam.name} : ${awayGoals.toString()}';
  }
}