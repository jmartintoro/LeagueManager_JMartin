import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:league_manager/other/AppData.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        middle: Text(
          'New League',
          style: TextStyle(fontSize: 25, color: CupertinoColors.black),
        ),
      ),
      child: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _createLeague(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _createLeague(BuildContext context) {
  AppData appData = Provider.of<AppData>(context);


  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),
      const Text(
        'LEAGUE CONFIGURATION',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.black,
        ),
      ),
      const SizedBox(height: 20),
      _buildTextField('League Name', appData.controllerName, appData),
      Container(
        height: 40,
        child: 
          GestureDetector(
            onTap: () => appData.canEdit ? appData.changeToCreateTeams(context) : null,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Teams'),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Text(appData.creatingTeams.length.toString()),
                  ),
                ],
              ),
            ),
          ),
      ),
      const Divider(),
      const SizedBox(height: 20,),
      const Text(
        'GAME CONFIGURATION',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.black,
        ),
      ),
      const SizedBox(height: 20),
      _buildNumericField("Points for victory", appData.winPointsController, 3, 0, 9, appData),
      _buildNumericField("Points for tie", appData.tiePointsController, 1, -9, 9, appData),
      _buildNumericField("Points for defeat", appData.loosePointsController, 0, -9, 9, appData),
      Center(
        child: CupertinoButton.filled(
          padding: EdgeInsets.all(10),
          child: const Text(
              'CREATE',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          onPressed:() =>  appData.createLeague(context),
          ),
      ),
      const SizedBox(height: 8,)
    ],
  );
}

Widget _buildTextField(String label, TextEditingController controller, AppData appData) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label),
          const SizedBox(width: 15),
          SizedBox(
            height: 40,
            width: 200,
            child: CupertinoTextField(
              placeholder: 'Enter $label',
              controller: controller,
              enabled: appData.canEdit,
            ),
          ),
        ],
      ),
      const Divider()
    ],
  );
}

Widget _buildNumericField(String label, TextEditingController controller, int defaultNum, int minNumber, int maxNumber, AppData appData) {
  controller.text = defaultNum.toString();
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label),
          const SizedBox(width: 15),
          SizedBox(
            height: 40,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () { 
                    int currentValue = int.parse(controller.text);
                    if (currentValue > minNumber) {
                      controller.text = (int.parse(controller.text) - 1).toString();
                    }
                  },
                  child: const Icon(CupertinoIcons.minus_circled),
                ),
                const SizedBox(width: 5,),
                SizedBox(
                  width: 30,
                  height: 40,
                  child: CupertinoTextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    enabled: false,
                  ),
                ),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: () { 
                    int currentValue = int.parse(controller.text);
                    if (currentValue < maxNumber) {
                      controller.text = (currentValue + 1).toString();
                    }
                  },
                  child: const Icon(CupertinoIcons.add_circled),
                ),
              ],
            ),
          ),
          
        ],
      ),
      const Divider()
    ],
  );
}

Widget _buildSwitchButton(String label, ValueNotifier<bool> switchNotifier, AppData appData) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label),
          const SizedBox(width: 15),
          SizedBox(
            height: 40,
            width: 70,
            child: ValueListenableBuilder<bool>(
                valueListenable: switchNotifier,
                builder: (context, value, child) {
                  return CupertinoSwitch(
                    value: value,
                    
                    onChanged: (newValue) {
                      if (appData.canEdit) {
                        switchNotifier.value = newValue;
                        if (appData.canEdit) {
                          // Switch is ON
                        } else {
                          // Switch is OFF
                        }
                        appData.forceNotify();
                      }
                    },
                  );
                },
              ),
          ),
        ]
      ),
      const Divider()
    ]
  );
}

void comprover(String value, TextEditingController controller, int minNumber, int maxNumber) {
  if (value.isEmpty) {
    controller.text = "";
    return; 
  }

  int? intValue = int.tryParse(value);
  
  if (intValue != null) {
    if ( intValue < minNumber ) {
      controller.text = minNumber.toString();
    } else if ( intValue > maxNumber ) {
      controller.text = maxNumber.toString();
    }
  } else {
    controller.text = "";
  }
}
