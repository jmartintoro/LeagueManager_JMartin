// ignore_for_file: file_names, prefer_initializing_formals

import 'package:league_manager/other/Matchday.dart';
import 'package:league_manager/other/Team.dart';

enum Mode {
  LEAGUE
}

class League {
  String name = "";
  Mode mode = Mode.LEAGUE;
  int teamsNum = 0;
  List<Team> teams = [];
  int wPoints = 3;
  int tPoints = 1;
  int lPoints = 0;
  List<Matchday> matchdays = [];

  League(String name, Mode mode, int teamsNum, List<Team> teams, int wPoints, int tPoints, int lPoints, List<Matchday> matchdays) {
    this.name = name;
    this.mode = mode;
    this.teamsNum = teamsNum;
    this.teams = teams;
    this.wPoints = wPoints;
    this.tPoints = tPoints;
    this.lPoints = lPoints;
    this.matchdays = matchdays;
  }

  @override
  String toString() {
    return 'League{name: $name, mode: $mode, teamsNum: $teamsNum, teams: $teams, wPoints: $wPoints, tPoints: $tPoints, lPoints: $lPoints, matchdays: $matchdays}';
  }
  
}