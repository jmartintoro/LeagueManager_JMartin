import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:league_manager/other/AppData.dart';
import 'package:league_manager/app.dart';

void main() async {
  try {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      WidgetsFlutterBinding.ensureInitialized();
      await WindowManager.instance.ensureInitialized();
      windowManager.waitUntilReadyToShow().then(showWindow);
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const App(),
    ),
  );
}

void showWindow(_) async {
  windowManager.setMinimumSize(const Size(400.0, 600.0));
  await windowManager.setTitle('LeagueManager - JMartin');
}
