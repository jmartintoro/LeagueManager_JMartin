import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:league_manager/other/League.dart';
import 'package:league_manager/other/AppData.dart';

class LeaguePage extends StatefulWidget {
  const LeaguePage({super.key});

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: false);
    
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: const Text(
          'League Page',
          style: TextStyle(fontSize: 25, color: CupertinoColors.black),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _myLeagues(context),
            ]
          ),
        ),
      )
    );
  }
}

Center _myLeagues(BuildContext context) {
  AppData appData = Provider.of<AppData>(context);

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("League page",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ],
    ),
  );
}

