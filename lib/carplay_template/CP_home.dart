import 'package:delo_automotive/main.dart';
import '../repository/podcast_repo.dart';
import 'package:flutter_carplay/flutter_carplay.dart';
import 'package:flutter/services.dart';

CPConnectionStatusTypes connectionStatus = CPConnectionStatusTypes.unknown;
final FlutterCarplay flutterCarplay = FlutterCarplay();

class CarPlayTemplate {
  List<CPListSection> section1Items = [];
  List<CPListSection> section2Items = [];

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
      // print('podcast list length ${value!.playlist!.length}');
      podcastList = value;

      section2Items = [];
      section2Items.add(CPListSection(
          items:
              // podcastList != null?
              podcastList!.playlist!
                  .map((e) => CPListItem(
                        text: e.title.toString(),
                        detailText: e.description.toString(),
                        onPress: (complete, self) {
                          openNowPlayingTemplate(
                              e.title,
                              e.description,
                              e.duration?.toString(),
                              "https://www.delo.si/play/2117622?premium=64483302",
                              e.image);
                          complete();
                        },
                      ))
                  .toList()
          // : categoryList
          //     .map((e) => CPListItem(
          //           text: 'Loading',
          //           detailText: "Detail Text",
          //           image: 'images/flutter_1080px.png',
          //           onPress: (complete, self) {
          //             openNowPlayingTemplate(null, null, null, null, null);
          //             complete();
          //           },
          //         ))
          //     .toList(),
          ));
      showPodcastList();
    });
  }

  initCarPlay() {
    section1Items.add(
      CPListSection(
        items: podcastCategories
            .map((e) => CPListItem(
                  text: e.title,
                  onPress: (complete, self) {
                    updatePodcastList(e.contentId);
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
                    onPress: (complete, self) {
                      openNowPlayingTemplate(
                          e.title,
                          e.description,
                          e.duration?.toString(),
                          "https://www.delo.si/play/2117622?premium=64483302",
                          e.image);
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
                      openNowPlayingTemplate(null, null, null, null, null);
                      complete();
                    },
                  ))
              .toList(),
    ));

    createCategoryList();
    flutterCarplay.addListenerOnConnectionChange(onCarplayConnectionChange);
  }

  createCategoryList() {
    FlutterCarplay.setRootTemplate(
      rootTemplate: CPTabBarTemplate(
        templates: [
          CPListTemplate(
            trailingButton: [
              CPBarButton(
                  onPress: () {
                    FlutterCarplay.pop(animated: true);
                  },
                  style: CPBarButtonStyles.rounded,
                  title: "1st page")
            ],
            sections: section1Items,
            title: "Kategorije",
            systemIcon: "list.bullet.below.rectangle",
          )
        ],
      ),
      animated: true,
    );
    flutterCarplay.forceUpdateRootTemplate();
  }

  showPodcastList() {
    FlutterCarplay.push(
      animated: true,
      template: CPListTemplate(
          trailingButton: [
            CPBarButton(
                onPress: () {
                  print("2nd");
                  FlutterCarplay.pop(animated: true);
                  FlutterCarplay.push(
                      template: CPListTemplate(
                          sections: [CPListSection(header: 'empty', items: [CPListItem(text: 'Hello')])],
                          systemIcon: 'play',
                          trailingButton: []));
                },
                style: CPBarButtonStyles.none,
                title: "2nd"),
          ],
          sections: section2Items,
          backButton: CPBarButton(
            title: "",
            style: CPBarButtonStyles.none,
            onPress: () {
              FlutterCarplay.pop(animated: true);
            },
          ),
          showsTabBadge: true,
          title: "Podkasti",
          systemIcon: "play",
          emptyViewTitleVariants: ["Loading"],
          emptyViewSubtitleVariants: ["Please wait..."]),
    );
  }

  disposeCarplay() {
    flutterCarplay.removeListenerOnConnectionChange();
  }

  void onCarplayConnectionChange(CPConnectionStatusTypes status) {
    connectionStatus = status;
  }

  void openNowPlayingTemplate(String? title, String? artist, String? duration,
      String? link, String? img) {
    FlutterCarplay.push(
        template: CPNowPlayingTemplate(title: 'Now Playing title'));
    playMusic(title, artist, duration, link, img);
  }

  // Method to invoke platform channel to play music
  void playMusic(String? title, String? artist, String? duration, String? link,
      String? img) async {
    const platform = MethodChannel('music_player');
    try {
      await platform.invokeMethod('playMusic', {
        'title': title,
        'artist': artist,
        'duration': duration,
        'link': link,
        'img': img
      });
    } on PlatformException catch (e) {
      print("Failed to play music: '${e.message}'.");
    }
  }
}
