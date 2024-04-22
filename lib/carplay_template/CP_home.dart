import 'dart:io';

import '../repository/podcast_list_model.dart';
import '../repository/podcast_menu_model.dart';
import '../repository/podcast_repo.dart';
import 'package:flutter_carplay/flutter_carplay.dart';

CPConnectionStatusTypes connectionStatus = CPConnectionStatusTypes.unknown;
final FlutterCarplay flutterCarplay = FlutterCarplay();
List<PodcastMenuModel> podcastCategories = [];
PodcastListData? podcastList;

class CarPlayTemplate {
  List<CPListSection> section1Items = [];
  List<CPListSection> section2Items = [];

  CPListTemplate firstTab = CPListTemplate(
    sections: [],
    title: "Kategorije",
    systemIcon: "list.bullet.below.rectangle",
  );

  CPListTemplate secondTab = CPListTemplate(
    sections: [],
    title: "Podkasti",
    systemIcon: "play",
  );

  CPListTemplate? selectedTemplate;

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

  updatePodcastList(String id) async {
    await PodcastRepository().getPodcastList(id).then((value) {
      print('podcast list length ${value!.playlist!.length}');
      podcastList = value;

      section2Items = [];
      section2Items.add(CPListSection(
        items: podcastList != null
            ? podcastList!.playlist!
                .map((e) => CPListItem(
                      text: e.title.toString(),
                      detailText: e.description.toString(),
                      // image: e.image,
                      onPress: (complete, self) {
                        openNowPlayingTemplate();
                        complete();
                      },
                    ))
                .toList()
            : categoryList
                .map((e) => CPListItem(
                      text: 'Loading',
                      detailText: "Detail Text",
                      image: 'images/flutter_1080px.png',
                      onPress: (complete, self) {
                        openNowPlayingTemplate();
                        complete();
                      },
                    ))
                .toList(),
      ));

      // FlutterCarplay.setRootTemplate(
      //   rootTemplate: CPTabBarTemplate(
      //     templates: [
      //       CPListTemplate(
      //         sections: section1Items,
      //         title: "Kategorije",
      //         systemIcon: "list.bullet.below.rectangle",
      //       ),
      //       CPListTemplate(
      //         sections: section2Items,
      //         title: "Podkasti",
      //         systemIcon: "play",
      //       ),
      //     ],
      //   ),
      //   animated: true,
      // );
      // FlutterCarplay.push(
      //   template: CPListTemplate(
      //       sections: section2Items,
      //       title: "Podkasti",
      //       systemIcon: "play",
      //       backButton: CPBarButton(
      //           title: "Back",
      //           style: CPBarButtonStyles.none,
      //           onPress: () {
      //             FlutterCarplay.pop(animated: true);
      //     },
      //   )
      //     ),
      //   animated: true,
      // );

      // flutterCarplay.forceUpdateRootTemplate();
    });
  }

  initCarPlay() {
    section1Items.add(
      CPListSection(
        items: podcastCategories
            .map((e) => CPListItem(
                  text: e.title,
                  onPress: (complete, self) {
                    // updatePodcastList(e.contentId);
                    // pushToPodcastList();
                    FlutterCarplay.setRootTemplate(
                      rootTemplate: CPTabBarTemplate(
                        templates: [
                          CPListTemplate(
                            backButton: CPBarButton(
                              title: "Back",
                              style: CPBarButtonStyles.none,
                              onPress: () {
                                initCarPlay();
                              },
                            ),
                            sections: section2Items,
                            title: "Kategorije",
                            systemIcon: "list.bullet.below.rectangle",
                          ),
                          // CPListTemplate(
                          //   sections: section2Items,
                          //   title: "Podkasti",
                          //   systemIcon: "play",
                          // ),
                        ],
                      ),
                      animated: true,
                    );
                    flutterCarplay.forceUpdateRootTemplate();
                    complete();
                  },
                ))
            .toList(),
      ),
    );

    section2Items.add(CPListSection(
      items: podcastList != null
          ? podcastList!.playlist!
              .map((e) => CPListItem(
                    text: e.title.toString(),
                    detailText: e.description.toString(),
                    // image: e.image,
                    onPress: (complete, self) {
                      openNowPlayingTemplate();
                      complete();
                    },
                  ))
              .toList()
          : categoryList
              .map((e) => CPListItem(
                    text: 'Loading',
                    detailText: "Detail Text",
                    image: 'images/flutter_1080px.png',
                    onPress: (complete, self) {
                      openNowPlayingTemplate();
                      complete();
                    },
                  ))
              .toList(),
    ));

    FlutterCarplay.setRootTemplate(
      rootTemplate: CPTabBarTemplate(
        templates: [
          CPListTemplate(
            sections: section1Items,
            title: "Kategorije",
            systemIcon: "list.bullet.below.rectangle",
          ),
          // CPListTemplate(
          //   sections: section2Items,
          //   title: "Podkasti",
          //   systemIcon: "play",
          // ),
        ],
      ),
      animated: true,
    );
    flutterCarplay.forceUpdateRootTemplate();
    flutterCarplay.addListenerOnConnectionChange(onCarplayConnectionChange);
  }

  disposeCarplay() {
    flutterCarplay.removeListenerOnConnectionChange();
  }

  void onCarplayConnectionChange(CPConnectionStatusTypes status) {
    // Do things when carplay state is connected, background or disconnected
    // setState(() {
    connectionStatus = status;
    // });
  }

  void addNewTemplate(CPListTemplate newTemplate) {
    final currentRootTemplate = FlutterCarplay.rootTemplate!;

    currentRootTemplate.templates.add(newTemplate);

    FlutterCarplay.setRootTemplate(
      rootTemplate: currentRootTemplate,
      animated: true,
    );
    flutterCarplay.forceUpdateRootTemplate();
  }

  void removeLastTemplate() {
    final currentRootTemplate = FlutterCarplay.rootTemplate!;

    currentRootTemplate.templates.remove(currentRootTemplate.templates.last);

    FlutterCarplay.setRootTemplate(
      rootTemplate: currentRootTemplate,
      animated: true,
    );

    flutterCarplay.forceUpdateRootTemplate();
  }

  void openNowPlayingTemplate() {
    FlutterCarplay.push(
        template: CPNowPlayingTemplate(title: 'Now Playing title'));
  }

  void pushToPodcastList() {
    FlutterCarplay.push(
      template: CPTabBarTemplate(
        templates: [
          CPListTemplate(
            sections: section2Items,
            title: "Kategorije",
            systemIcon: "list.bullet.below.rectangle",
          ),
        ],
      ),
    );
  }

  void openGridTemplate() {
    FlutterCarplay.push(
      template: CPGridTemplate(
        title: "Grid Template",
        buttons: [
          for (var i = 1; i < 9; i++)
            CPGridButton(
              titleVariants: ["Item $i"],
              // ----- TRADEMARKS RIGHTS INFORMATION BEGIN -----
              // The official Flutter logo is used from the link below.
              // For more information, please visit and read
              // Flutter Brand Guidelines Website: https://flutter.dev/brand
              //
              // FLUTTER AND THE RELATED LOGO ARE TRADEMARKS OF Google LLC.
              // WE ARE NOT ENDORSED BY OR AFFILIATED WITH Google LLC.
              // ----- TRADEMARKS RIGHTS INFORMATION END -----
              image: 'images/logo_flutter_1080px_clr.png',
              onPress: () {
                print("Grid Button $i pressed");
              },
            ),
        ],
      ),
      animated: true,
    );
  }

  void openListTemplate() {
    FlutterCarplay.push(
      template: CPListTemplate(
        sections: [
          CPListSection(
            header: "A Section",
            items: [
              CPListItem(text: "Item 1"),
              CPListItem(text: "Item 2"),
              CPListItem(text: "Item 3"),
              CPListItem(text: "Item 4"),
            ],
          ),
          CPListSection(
            header: "B Section",
            items: [
              CPListItem(text: "Item 5"),
              CPListItem(text: "Item 6"),
            ],
          ),
          CPListSection(
            header: "C Section",
            items: [
              CPListItem(text: "Item 7"),
              CPListItem(text: "Item 8"),
            ],
          ),
        ],
        systemIcon: "systemIcon",
        title: "List Template",
        backButton: CPBarButton(
          title: "Back",
          style: CPBarButtonStyles.none,
          onPress: () {
            FlutterCarplay.pop(animated: true);
          },
        ),
      ),
      animated: true,
    );
  }
}
