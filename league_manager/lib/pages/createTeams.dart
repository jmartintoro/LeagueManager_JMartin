import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:league_manager/other/AppData.dart';

class CreateTeams extends StatelessWidget {
  const CreateTeams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: const Text(
          'Teams',
          style: TextStyle(fontSize: 25, color: CupertinoColors.black),
        ),
        trailing: GestureDetector(
          onTap: () => _popupTeams(context),
          child: Icon(CupertinoIcons.add_circled),
        ),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: _createTeams(context, appData),
      ),
    );
  }

  Widget _createTeams(BuildContext context, AppData appData) {
    return appData.creatingTeams.isEmpty
        ? const Center(
            child: Text('There is no team. Press + to add a team'),
          )
        : ListView.builder(
            itemCount: appData.creatingTeams.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                color: CupertinoColors.systemBlue.withOpacity(0.1),
                child: Container(
                  height: 30,
                  child: Text(
                    appData.creatingTeams[index],
                    style: TextStyle(fontSize: 20)
                    ),
                ),
              );
            },
          );
  }

  void _popupTeams(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);
    final TextEditingController textController = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Team name:'),
          content: CupertinoTextField(
            autofocus: true,
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('ADD'),
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  appData.creatingTeams.add(textController.text);
                  appData.notifyListeners();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
