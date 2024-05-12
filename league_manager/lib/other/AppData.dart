import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_manager/other/League.dart';
import 'package:league_manager/other/Team.dart';
import 'package:league_manager/other/Match.dart';
import 'package:league_manager/other/Matchday.dart';
import 'package:league_manager/other/MatchScheduler.dart';
import 'package:league_manager/pages/creationPage.dart';
import 'package:league_manager/pages/createTeams.dart';
import 'package:league_manager/pages/homePage.dart';
import 'package:league_manager/pages/leaguePage.dart';

class AppData with ChangeNotifier {
  
  List<League> myLeagues = [];

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController winPointsController = TextEditingController();
  final TextEditingController tiePointsController = TextEditingController();
  final TextEditingController loosePointsController = TextEditingController();

  final PageController pageController = PageController(initialPage: 0);

  List<Team> creatingTeams = [];

  bool canEdit = true;
  bool canSave = true;

  int indexLeague = 0;


  void createLeague(BuildContext context) {
    canEdit = false;
    sleep(Duration(seconds: 1));
    addLeague(context);
    canEdit = true;
  }

  void addLeague(BuildContext context) {
    String name = controllerName.text.trim();
    int wPoints = 0;
    int tPoints = 0;
    int lPoints = 0;
    
    if (name.isEmpty) {
      throwPopup(context, "Name is empty");
      return;
    }

    if (creatingTeams.isEmpty) {
      throwPopup(context, "Teams are empty");
      return;
    } else if (creatingTeams.length <= 1) {
      throwPopup(context, "The minimum of teams is 2");
      return;
    }

    try {
      wPoints = int.parse(winPointsController.text);
      tPoints = int.parse(tiePointsController.text);
      lPoints = int.parse(loosePointsController.text);
    } catch (e) {
      throwPopup(context, "Complete the Game Configuration");
      return;
    }

    MatchScheduler scheduler = new MatchScheduler();

    // Generate original matchdays
    List<Matchday> matchdays = scheduler.generateMatchdays(creatingTeams);

    // Generate inverted matchdays with home/away swapped
    List<Matchday> invertedMatchdays = scheduler.generateInvertedMatchdays(matchdays);

    // Combine the original and inverted matchdays
    List<Matchday> allMatchdays = [...matchdays, ...invertedMatchdays];

    for (var matchday in allMatchdays) {
      print("Matchday ${matchday.dayNumber}:");
      for (var match in matchday.matches) {
        print(match);
      }
      print("");
    }

    List<Team> teams = List<Team>.from(creatingTeams);


    myLeagues.add(League(name, Mode.LEAGUE, teams.length, teams, wPoints, tPoints, lPoints, allMatchdays));
    print(myLeagues[0]);
    creatingTeams.clear();
    controllerName.text = "";

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void throwPopup(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('ERROR', style: TextStyle(color: CupertinoColors.systemRed)),
          content: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                message, 
                style: const TextStyle(fontSize: 14)
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(
                'DONE',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  List<Match> generateMatches(List<Team> teams) {
    List<Match> matches = [];

    for (int i = 0; i < teams.length; i++) {
      for (int j = 0; j < teams.length; j++) {
        if (teams[i] != teams[j]) { // Ensure a team doesn't encounter itself
        Match match1 = Match(teams[i],teams[j]);
        Match match2 = Match(teams[j], teams[i]);

        if (!matches.contains(match1) && !matches.contains(match2)) {
          matches.add(match1); // Add the forward match
        }
      }
      }

    }

    return matches;
  }

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateTable() {
    canSave = false;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      
      for (int i = 0; i < myLeagues[indexLeague].teamsNum; i++) {
        myLeagues[indexLeague].teams[i].points = 0;
      }

      for (Matchday matchday in myLeagues[indexLeague].matchdays) {
        for (Match match in matchday.matches) {
          if (match.homeGoals > match.awayGoals) {
            match.homeTeam.points += myLeagues[indexLeague].wPoints;
            match.awayTeam.points += myLeagues[indexLeague].lPoints;
          } else if (match.homeGoals < match.awayGoals) {
            match.homeTeam.points += myLeagues[indexLeague].lPoints;
            match.awayTeam.points += myLeagues[indexLeague].wPoints;
          } else {
            match.homeTeam.points += myLeagues[indexLeague].tPoints;
            match.awayTeam.points += myLeagues[indexLeague].tPoints;
          }
        }
      }
            
      
      canSave = true;
      notifyListeners(); 
    });
  }

  void changeToCreationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreationPage()),
    );
  }

  void changeToCreateTeams(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTeams()),
    );
  }

  void changeToLeaguePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeaguePage()),
    );
  }

  void forceNotify() {
    notifyListeners();
  }
}