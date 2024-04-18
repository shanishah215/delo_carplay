import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:delo_automotive/carplay_template/CP_home.dart';
import 'package:delo_automotive/repository/podcast_repo.dart';
import 'package:delo_automotive/screens/home_screen.dart';
import 'package:delo_automotive/screens/no_internet.dart';
import 'package:delo_automotive/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carplay/flutter_carplay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    PodcastRepository().getPodcastList('Ib6cSYfC');
    CarPlayTemplate().initCarPlay();
  }

  @override
  void dispose() {
    CarPlayTemplate().disposeCarplay();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    AppTheme.initStream();
    return StreamBuilder<ThemeMode>(
      stream: AppTheme.currentThemeStream.stream,
      builder: (context, themeSnapshot) {
        return MaterialApp(
          theme: AppTheme.appLightTheme(),
          darkTheme: AppTheme.appDarkTheme(),
          themeMode: themeSnapshot.data ?? ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (BuildContext context,
                AsyncSnapshot<List<ConnectivityResult>> snapshot) {
              if (snapshot.data != [] && snapshot.data != null) {
                return Stack(
                  children: [
                    const HomeScreen(),
                    snapshot.data!.contains(ConnectivityResult.none)
                        ? NoInternet()
                        : Container()
                  ],
                );
              } else {
                return const HomeScreen();
              }
            },
          ),
        );
      },
    );
  }
}
