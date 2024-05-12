import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_manager/other/Matchday.dart';
import 'package:league_manager/other/Match.dart';
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
    AppData appData = Provider.of<AppData>(context, listen: true);

    return CupertinoTabScaffold(
      tabBar: _tabBar(context),
      tabBuilder: (context, index) {
        return CupertinoPageScaffold(
          backgroundColor: const Color.fromARGB(255, 234, 234, 234),
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.white,
            middle: Text(
              '${appData.myLeagues[appData.indexLeague].name} Page',
              style: const TextStyle(fontSize: 25, color: CupertinoColors.black),
            ),
            trailing: 
              index == 1
                ? appData.canSave 
                  ? GestureDetector( 
                    onTap: () => appData.updateTable(), 
                    child: const Icon(
                      CupertinoIcons.refresh_circled, 
                      color: CupertinoColors.activeBlue,
                      )
                    )
                  : const Icon(
                      CupertinoIcons.refresh_circled, 
                      color: CupertinoColors.inactiveGray,
                      )
                : null,
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
                'Points ',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              numeric: true,
            ),
            DataColumn(
              label: Text(
                'Goals ',
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
  AppData appData = Provider.of<AppData>(context, listen: true);
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () => appData.pageController.animateToPage(
                appData.pageController.page!.round() - 1, 
                duration: Durations.medium1, 
                curve: Curves.linear
              ), 
              child: const Icon(CupertinoIcons.minus_circle),
            ),
          const SizedBox(width: 24,),
          const Text('Matchday', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 24,),
          GestureDetector(
              onTap: () => appData.pageController.animateToPage(
                appData.pageController.page!.round() + 1, 
                duration: Durations.medium1, 
                curve: Curves.linear
              ), 
              child: const Icon(CupertinoIcons.add_circled),
            ),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        height: ((appData.myLeagues[appData.indexLeague].teams.length/2)*150)+60,
        child: PageView(
          controller: appData.pageController,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (int i = 0; i < appData.myLeagues[appData.indexLeague].matchdays.length; i++) 
              _matchdayContent(context, i+1), 
          ],
        ),
      ),
    ],
  );
}

Widget _matchdayContent(BuildContext context, int pageIndex) {
  AppData appData = Provider.of<AppData>(context, listen: true);
  Matchday matchday = appData.myLeagues[appData.indexLeague].matchdays[pageIndex-1];
  
  return Column(
    children: [
      Text(
        'Matchday $pageIndex',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: matchday.matches.length,
          itemBuilder: (context, index) {
            Match match = matchday.matches[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    match.homeTeam.name, 
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10,),
                  _goalsButton(match, true, new TextEditingController(), appData),
                  const SizedBox(width: 10,),
                  const Text(
                    ' vs ', 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10,),
                  _goalsButton(match, false, new TextEditingController(), appData),
                  Text(
                    match.awayTeam.name, 
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }
        )
      )
    ]
  );
}

Column _goalsButton(Match match, bool isHome, TextEditingController controller, AppData appData) {
  controller.text = (isHome ? match.homeGoals : match.awayGoals).toString();
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 50,
        height: 25,
        child: CupertinoButton(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
          padding: EdgeInsets.zero,
          onPressed: () {
            int currentValue = int.parse(controller.text);
            controller.text = (currentValue + 1).toString();
            isHome ? match.homeGoals++ : match.awayGoals++;
            isHome ? match.homeTeam.scoredGoals++ : match.awayTeam.scoredGoals++;
            isHome ? match.awayTeam.concededGoals++ : match.homeTeam.concededGoals++;
          },
          color: CupertinoColors.systemBlue,
          child: const Icon(CupertinoIcons.add, size: 24),
        )
      ),
      SizedBox(
        width: 50,
        height: 30,
        child: CupertinoTextField(
          textAlign: TextAlign.center,
          controller: controller,
          enabled: false,
        ),
      ),
      SizedBox(
        width: 50,
        height: 25,
        child: CupertinoButton(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
          padding: EdgeInsets.zero,
          onPressed: () {
            int currentValue = int.parse(controller.text);
            if (currentValue > 0) {
              controller.text = (currentValue - 1).toString();
              isHome ? match.homeGoals-- : match.awayGoals--;
              isHome ? match.homeTeam.scoredGoals-- : match.awayTeam.scoredGoals--;
              isHome ? match.awayTeam.concededGoals-- : match.homeTeam.concededGoals--;
            }
          },
          color: CupertinoColors.systemBlue,
          child: const Icon(CupertinoIcons.minus,size: 24),
        )
      ),
    ],
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
    onTap: (index) => appData.onItemTapped(index),
  );
}
