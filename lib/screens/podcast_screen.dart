import 'package:delo_automotive/repository/podcast_list_model.dart';
import 'package:delo_automotive/widgets/podcast_list_tile.dart';
import '../screens/media_player.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key, required this.podcastList, required this.categoryName});
  final PodcastListData podcastList;
  final String categoryName;

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> with TickerProviderStateMixin {
  ScrollController podcastController = ScrollController();

  List<String> categoryList = [
    'Najnovejši podkasti',
    'Moč politike',
    'Od srede do srede',
    'Super moč',
    'Odprta kuhinja',
    'Moč gospodarstva',
    'Najnovejši podkasti',
    'Moč politike',
    'Od srede do srede',
    'Super moč',
    'Odprta kuhinja',
    'Moč gospodarstva'
  ];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 20,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 80),
            child: Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(Constants.backArrowLight)),
                  Expanded(
                    // flex: 10,
                    child: TabBar(
                      controller: tabController,
                      onTap: (value) {
                        tabController.index = value;
                        setState(() {});
                      },
                      labelStyle: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                      ),
                      labelColor: Theme.of(context).iconTheme.color,
                      unselectedLabelColor: Constants.lightThemeSubtitle,
                      indicatorColor: Theme.of(context).canvasColor,
                      dividerHeight: 0,
                      tabs: [
                        Tab(
                          icon: SvgPicture.asset(
                            Constants.podcastUnselectedIcon,
                            height: 42,
                            colorFilter: ColorFilter.mode(
                                tabController.index == 0
                                    ? Theme.of(context).iconTheme.color!
                                    : Theme.of(context).disabledColor,
                                BlendMode.srcIn),
                          ),
                          text: 'Podkasti',
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: AppTheme.currentThemeStream.stream,
                    builder: (context, themeSnapshot) {
                      ThemeMode theme = themeSnapshot.data ?? AppTheme.currentTheme;
                      print("here theme ${themeSnapshot.data}");
                      return Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MediaPlayer(
                                    continuePlaying: true,
                                  ),
                                ));
                          },
                          child: SvgPicture.asset(
                            theme == ThemeMode.light
                                ? Constants.mediaPlayerLightTheme
                                : Constants.mediaPlayerDarkTheme,
                            height: 70,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            )),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: TabBarView(
                controller: tabController,
                children: [
                  ListView.builder(
                    controller: podcastController,
                    itemCount: widget.podcastList.playlist?.length ?? 0,
                    padding:
                        const EdgeInsets.only(left: 40, top: 10, bottom: 8),
                    itemBuilder: (context, index) {
                      return podcastListTile(context,
                          title: widget.podcastList.playlist?[index].title ?? "Default", playlist: widget.podcastList.playlist?[index], categoryName: widget.categoryName);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () => scrollUp(),
                        child: Icon(
                          Icons.keyboard_arrow_up_sharp,
                          color: Theme.of(context).iconTheme.color,
                          size: 64,
                        )),
                    InkWell(
                        onTap: () => scrollDown(),
                        child: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Theme.of(context).iconTheme.color,
                          size: 64,
                        )),
                    StreamBuilder<ThemeMode>(
                        stream: AppTheme.currentThemeStream.stream,
                        builder: (context, themeSnapshot) {
                          debugPrint("current icon $themeSnapshot");
                          ThemeMode theme =
                              themeSnapshot.data ?? ThemeMode.light;
                          return InkWell(
                              onTap: () => AppTheme.toggleTheme(
                                  themeMode: theme == ThemeMode.light
                                      ? ThemeMode.dark
                                      : ThemeMode.light),
                              child: Icon(
                                theme == ThemeMode.light
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                color: Theme.of(context).iconTheme.color,
                                size: 44,
                              ));
                        })
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void scrollUp() {
      podcastController.animateTo(podcastController.offset - 300,
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut);
  }

  void scrollDown() {
      podcastController.animateTo(podcastController.offset + 300,
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut);
  }
}
