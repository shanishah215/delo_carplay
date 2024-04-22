import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import '../screens/home_screen.dart';
import '../screens/no_internet.dart';
import '../utils/theme.dart';
import 'package:flutter/material.dart';

import 'carplay_template/CP_home.dart';
import '../repository/podcast_repo.dart';

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
    getPodcastData();
  }

  getPodcastData() async {
    await PodcastRepository().getPodcastCategories().then((value) async {
      podcastCategories = value;
      debugPrint("length ${value.length.toString()}");
      await PodcastRepository()
          .getPodcastList(podcastCategories[0].contentId)
          .then((podcast) {
        podcastList = podcast;
        CarPlayTemplate().initCarPlay();
      });
    });
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
