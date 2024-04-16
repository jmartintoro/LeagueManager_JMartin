import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:league_manager/other/AppData.dart';

class LeaguePage extends StatefulWidget {
  const LeaguePage({Key? key}) : super(key: key);

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  static final List<Widget> _widgetOptions = <Widget>[
    _leagueInfo(),
    _tableView(),
    _matchday(),
  ];

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
                _widgetOptions.elementAt(index),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _leagueInfo() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'League info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _tableView() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Table Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _matchday() {
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
    items: <BottomNavigationBarItem>[
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
