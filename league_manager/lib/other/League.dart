// ignore_for_file: file_names, prefer_initializing_formals

import 'package:league_manager/other/Team.dart';

enum Mode {
  LEAGUE
}

class League {
  String name = "";
  Mode mode = Mode.LEAGUE;
  int teamsNum = 0;
  List<Team> teams = [];
  int rounds = 0;
  int wPoints = 3;
  int tPoints = 1;
  int lPoints = 0;

  League(String name, Mode mode, int teamsNum, List<Team> teams, int rounds, int wPoints, int tPoints, int lPoints) {
    this.name = name;
    this.mode = mode;
    this.teamsNum = teamsNum;
    this.teams = teams;
    this.rounds = rounds;
    this.wPoints = wPoints;
    this.tPoints = tPoints;
    this.lPoints = lPoints;
  }

  @override
  String toString() {
    return 'League{name: $name, mode: $mode, teamsNum: $teamsNum, teams: $teams, rounds: $rounds, wPoints: $wPoints, tPoints: $tPoints, lPoints: $lPoints}';
  }
  
}