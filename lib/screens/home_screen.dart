import 'package:delo_automotive/main.dart';

import '../screens/media_player.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';
import '../widgets/category_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ScrollController categoryController = ScrollController();

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
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 80),
            child: Row(
              children: [
                Expanded(
                  flex: 9,
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
                          Constants.categorySelectedIcon,
                          height: 42,
                          colorFilter: ColorFilter.mode(
                              tabController.index == 0
                                  ? Theme.of(context).iconTheme.color!
                                  : Theme.of(context).disabledColor,
                              BlendMode.srcIn),
                        ),
                        text: 'Kategorije',
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: StreamBuilder(
                      stream: AppTheme.currentThemeStream.stream,
                      builder: (context, themeSnapshot) {
                        ThemeMode theme = themeSnapshot.data ?? ThemeMode.light;
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
                    ))
              ],
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
                    shrinkWrap: true,
                    controller: categoryController,
                    itemCount: podcastCategories.length,
                    padding:
                        const EdgeInsets.only(left: 40, top: 10, bottom: 8),
                    itemBuilder: (context, index) {
                      return categoryListTile(context,
                          title: podcastCategories[index].title, categoryID: podcastCategories[index].contentId);
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
      categoryController.animateTo(categoryController.offset - 300,
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut);
  }

  void scrollDown() {
      categoryController.animateTo(categoryController.offset + 300,
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut);
  }
}
