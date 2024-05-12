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



  @override
  String toString() {
    return '${homeTeam.name} : ${homeGoals.toString()} vs ${awayTeam.name} : ${awayGoals.toString()}';
  }
}