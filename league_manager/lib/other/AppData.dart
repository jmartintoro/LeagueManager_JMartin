import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_manager/other/League.dart';
import 'package:league_manager/other/Team.dart';
import 'package:league_manager/pages/creationPage.dart';
import 'package:league_manager/pages/createTeams.dart';
import 'package:league_manager/pages/homePage.dart';
import 'package:league_manager/pages/leaguePage.dart';

class AppData with ChangeNotifier {
  List<League> myLeagues = [League("League1", Mode.LEAGUE, 23, [Team("Team 1"),Team("Second Team"),Team("3rd Team"),Team("FC Five"),Team("Team six")], 2, 3, 1, 0), League("League2", Mode.LEAGUE, 23, [Team("A"),Team("E"),Team("I")], 2, 3, 1, 0)];

  final TextEditingController controllerName = TextEditingController();
  final ValueNotifier<bool> switchNotifier = ValueNotifier<bool>(false);
  final TextEditingController roundsNumberController = TextEditingController();
  final TextEditingController winPointsController = TextEditingController();
  final TextEditingController tiePointsController = TextEditingController();
  final TextEditingController loosePointsController = TextEditingController();

  List<Team> creatingTeams = [];

  bool canEdit = true;

  int indexLeague = 0;


  void createLeague(BuildContext context) {
    canEdit = false;
    sleep(Duration(seconds: 2));
    addLeague(context);
    canEdit = true;

    // print(myLeagues);
  }

  void addLeague(BuildContext context) {
    String name = controllerName.text.trim();
    int rounds  = 0;
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

    if (switchNotifier.value) {
      try {
        rounds = int.parse(roundsNumberController.text);
      } catch (e) {
        throwPopup(context, "Rounds is empty");
        return;
      }
    }

    try {
      wPoints = int.parse(winPointsController.text);
      tPoints = int.parse(tiePointsController.text);
      lPoints = int.parse(loosePointsController.text);
    } catch (e) {
      throwPopup(context, "Complete the Game Configuration");
      return;
    }
    
    myLeagues.add(League(name, Mode.LEAGUE, creatingTeams.length, creatingTeams, rounds, wPoints, tPoints, lPoints));
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

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
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