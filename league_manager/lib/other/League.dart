// ignore_for_file: file_names, prefer_initializing_formals

import 'package:flutter/cupertino.dart';
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

    League({
    required this.name,
    required this.mode,
    required this.teamsNum,
    required this.teams,
    required this.wPoints,
    required this.tPoints,
    required this.lPoints,
    required this.matchdays,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mode': mode.toString().split('.').last,
      'teamsNum': teamsNum,
      'teams': teams.map((team) => team.toJson()).toList(),
      'wPoints': wPoints,
      'tPoints': tPoints,
      'lPoints': lPoints,
      'matchdays': matchdays.map((matchday) => matchday.toJson()).toList(),
    };
  }

  // fromJson method to convert JSON to League object
  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      name: json['name'],
      mode: Mode.LEAGUE, // Since mode is an enum, you may need additional logic here if it's stored differently in JSON
      teamsNum: json['teamsNum'],
      teams: List<Team>.from(json['teams'].map((teamJson) => Team.fromJson(teamJson))),
      wPoints: json['wPoints'],
      tPoints: json['tPoints'],
      lPoints: json['lPoints'],
      matchdays: List<Matchday>.from(json['matchdays'].map((matchdayJson) => Matchday.fromJson(matchdayJson))),
    );
  }
  @override
  String toString() {
    return 'League{name: $name, mode: $mode, teamsNum: $teamsNum, teams: $teams, wPoints: $wPoints, tPoints: $tPoints, lPoints: $lPoints, matchdays: $matchdays}';
  }
  
}