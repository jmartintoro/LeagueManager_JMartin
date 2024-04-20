import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:league_manager/other/AppData.dart';

class LeaguePage extends StatefulWidget {
  const LeaguePage({Key? key}) : super(key: key);

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: false);

    return CupertinoTabScaffold(
      tabBar: _tabBar(context), // Set the bottom navigation bar
      tabBuilder: (context, index) {
        return CupertinoPageScaffold(
          backgroundColor: const Color.fromARGB(255, 234, 234, 234),
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.white,
            middle: Text(
              '${appData.myLeagues[appData.indexLeague].name} Page',
              style: const TextStyle(fontSize: 25, color: CupertinoColors.black),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (index == 0) _leagueInfo(context),
                if (index == 1) _tableView(context), 
                if (index == 2) _matchday(context)
              ],  
            ),
          ),
        );
      },
    );
  }
}

Widget _leagueInfo(BuildContext context) {
  AppData appData = Provider.of<AppData>(context, listen: false);

  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'League Info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('League name: ${appData.myLeagues[appData.indexLeague].name}'),
              const Divider(),
              Text('Winning Points: ${appData.myLeagues[appData.indexLeague].wPoints}'),
              const SizedBox(height: 10,),
              Text('Tie Points: ${appData.myLeagues[appData.indexLeague].tPoints}'),
              const SizedBox(height: 10,),
              Text('Lose Points: ${appData.myLeagues[appData.indexLeague].lPoints}'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _tableView(BuildContext context) {
  AppData appData = Provider.of<AppData>(context, listen: false);
  double dataHeight = 30;

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Table',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        DataTable(
          sortColumnIndex: 1,
          sortAscending: true,
          headingRowHeight: dataHeight*1.3,
          dataRowMaxHeight: dataHeight,
          dataRowMinHeight: dataHeight,
          columnSpacing: BorderSide.strokeAlignOutside,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Points',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              numeric: true,
            ),
            DataColumn(
              label: Text(
                'Goals',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              numeric: true,
            ),
            DataColumn(
              label: Text(
                'Played',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              numeric: true,
            ),
          ],
          rows: appData.myLeagues[appData.indexLeague].teams.map((data) => DataRow(
            cells: <DataCell>[
              DataCell(
                Container(
                  constraints: BoxConstraints(maxWidth: 150, maxHeight: 20),
                  child: Text(data.name, overflow: TextOverflow.ellipsis,),
                ),
              ), 
              DataCell(Text(data.points.toString(), style: TextStyle(fontWeight: FontWeight.bold),)), 
              DataCell(Text("${data.scoredGoals}:${data.concededGoals}")), 
              DataCell(Text(data.gamesPlayed.toString())), 
            ],
          )).toList(),
        )
      ],
    ),
  );
}

Widget _matchday(BuildContext context) {
  AppData appData = Provider.of<AppData>(context, listen: false);

  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Matchday Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

CupertinoTabBar _tabBar(BuildContext context) {
  AppData appData = Provider.of<AppData>(context, listen: true);
  return CupertinoTabBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: 'League',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.sportscourt),
        label: 'Table',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.calendar),
        label: 'Matchday',
      ),
    ],
    currentIndex: appData.selectedIndex,
    onTap: (index) => appData.onItemTapped(index),
  );
}
