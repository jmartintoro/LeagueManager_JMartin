import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_manager/other/League.dart';
import 'package:provider/provider.dart';
import 'package:league_manager/other/AppData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: false);
    
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: CupertinoColors.white,
        middle: const Text(
          'League Manager',
          style: TextStyle(fontSize: 25, color: CupertinoColors.black),
        ),
        trailing: GestureDetector(
          onTap: () => appData.changeToCreationPage(context),
          child: Icon(CupertinoIcons.add_circled),
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
              const SizedBox(height: 50),
              SizedBox(
                height: 14,
                child: Text(
                  'LeagueManager by JoelMartin',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w100,
                    color: CupertinoColors.black.withOpacity(0.7)
                  )
                )
              )
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
          const Text("My Leagues",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: MediaQuery.of(context).size.height-150,
            child: appData.myLeagues.isEmpty 
              ? const Text("No Leagues") 
              : ListView.builder(
                  itemCount: appData.myLeagues.length,
                  itemBuilder: (context, index) =>
                      teamList(appData, context, index),
                ),
          ),
        ],
    ),
  );
}

Widget teamList(AppData appData, BuildContext context, int index) {
  return GestureDetector(
    onTap: () { 
      appData.indexLeague = index;
      appData.changeToLeaguePage(context);
      },
    child: Container(
      height: 40,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(appData.myLeagues[index].name),
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: Icon(CupertinoIcons.trash, color: CupertinoColors.destructiveRed),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    ),
  );
}
