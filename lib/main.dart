import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:delo_automotive/repository/podcast_list_model.dart';
import 'package:delo_automotive/repository/podcast_menu_model.dart';
import 'package:delo_automotive/utils/constants.dart';
import '../screens/home_screen.dart';
import '../screens/no_internet.dart';
import '../utils/theme.dart';
import 'package:flutter/material.dart';
import 'carplay_template/CP_home.dart';
import '../repository/podcast_repo.dart';

void main() {
  runApp(const MyApp());
}
List<PodcastMenuModel> podcastCategories = [];
PodcastListData? podcastList;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool gotCategory = false;

  @override
  void initState() {
    super.initState();
    AppTheme.initStream();
    getPodcastData();
  }

  getPodcastData() async {
    await PodcastRepository().getPodcastCategories().then((value) async {
      podcastCategories = value;
      debugPrint("length ${value.length.toString()}");
      if (Platform.isIOS) {
        CarPlayTemplate().initCarPlay();
      }
      setState(() {
        gotCategory = true;
      });
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      CarPlayTemplate().disposeCarplay();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    gotCategory ? const HomeScreen() : const Center(child: CircularProgressIndicator(color: Constants.lightThemeBlue,),),
                    snapshot.data!.contains(ConnectivityResult.none)
                        ? NoInternet()
                        : Container()
                  ],
                );
              } else {
                return gotCategory ? const HomeScreen() : const Center(child: CircularProgressIndicator(color: Constants.lightThemeBlue,),);
              }
            },
          ),
        );
      },
    );
  }
}
