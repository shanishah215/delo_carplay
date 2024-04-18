import 'dart:io';

import 'package:delo_automotive/repository/podcast_list_model.dart';
import 'package:delo_automotive/repository/podcast_menu_model.dart';
import 'package:delo_automotive/repository/podcast_repo.dart';
import 'package:flutter_carplay/flutter_carplay.dart';

CPConnectionStatusTypes connectionStatus = CPConnectionStatusTypes.unknown;
final FlutterCarplay flutterCarplay = FlutterCarplay();
List<PodcastMenuModel> podcastCategories = [];
PodcastListData? podcastList;

class CarPlayTemplate {
  List<CPListSection> section1Items = [];
  List<CPListSection> section2Items = [];

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
                      image: e.image,
                    ))
                .toList()
            : categoryList
                .map((e) => CPListItem(
                      text: 'Loading',
                      detailText: "Detail Text",
                      image: 'images/flutter_1080px.png',
                    ))
                .toList(),
      ));

      CPTabBarTemplate tabTemplate = CPTabBarTemplate(
        templates: [
          CPListTemplate(
            sections: section1Items,
            title: "Kategorije",
            systemIcon: "list.bullet.below.rectangle",
          ),
          CPListTemplate(
            sections: section2Items,
            title: "Podkasti",
            systemIcon: "play",
          ),
        ],
      );

      FlutterCarplay.setRootTemplate(
        rootTemplate: tabTemplate,
        animated: true,
      );

      flutterCarplay.forceUpdateRootTemplate();
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

    // final List<CPListSection> section2Items = [];
    // section2Items.add(CPListSection(
    //   items: [
    //     CPListItem(
    //       text: "Now PLaying",
    //       detailText: "Action template that the user can perform on an alert",
    //       onPress: (complete, self) {
    //         openNowPlayingTemplate();
    //         complete();
    //       },
    //     ),
    //     CPListItem(
    //       text: "Alert",
    //       detailText: "Action template that the user can perform on an alert",
    //       onPress: (complete, self) {
    //         // showAlert();
    //         complete();
    //       },
    //     ),
    //     CPListItem(
    //       text: "Grid Template",
    //       detailText: "A template that displays and manages a grid of items",
    //       onPress: (complete, self) {
    //         openGridTemplate();
    //         complete();
    //       },
    //     ),
    //     CPListItem(
    //       text: "Action Sheet",
    //       detailText: "A template that displays a modal action sheet",
    //       onPress: (complete, self) {
    //         // showActionSheet();
    //         complete();
    //       },
    //     ),
    //     CPListItem(
    //       text: "List Template",
    //       detailText: "Displays and manages a list of items",
    //       onPress: (complete, self) {
    //         openListTemplate();
    //         complete();
    //       },
    //     ),
    //     CPListItem(
    //       text: "Information Template",
    //       detailText: "Displays a list of items and up to three actions",
    //       onPress: (complete, self) {
    //         openInformationTemplate();
    //         complete();
    //       },
    //     ),
    //     CPListItem(
    //       text: "Point Of Interest Template",
    //       detailText: "Displays a Map with points of interest.",
    //       onPress: (complete, self) {
    //         openPoiTemplate();
    //         complete();
    //       },
    //     ),
    //   ],
    //   header: "Features",
    // ));

    section2Items.add(CPListSection(
      items: podcastList != null
          ? podcastList!.playlist!
              .map((e) => CPListItem(
                    text: e.title.toString(),
                    detailText: e.description.toString(),
                    image: 'images/flutter_1080px.png',
                  ))
              .toList()
          : categoryList
              .map((e) => CPListItem(
                    text: 'Loading',
                    detailText: "Detail Text",
                    image: 'images/flutter_1080px.png',
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
          CPListTemplate(
            sections: section2Items,
            title: "Podkasti",
            systemIcon: "play",
          ),
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

//   void showAlert() {
//   FlutterCarplay.showAlert(
//     template: CPAlertTemplate(
//       titleVariants: ["Alert Title"],
//       actions: [
//         CPAlertAction(
//           title: "Okay",
//           style: CPAlertActionStyles.normal,
//           onPress: () {
//             FlutterCarplay.popModal(animated: true);
//             print("Okay pressed");
//           },
//         ),
//         CPAlertAction(
//           title: "Cancel",
//           style: CPAlertActionStyles.cancel,
//           onPress: () {
//             FlutterCarplay.popModal(animated: true);
//             print("Cancel pressed");
//           },
//         ),
//         CPAlertAction(
//           title: "Remove",
//           style: CPAlertActionStyles.destructive,
//           onPress: () {
//             FlutterCarplay.popModal(animated: true);
//             print("Remove pressed");
//           },
//         ),
//       ],
//     ),
//   );
// }

// void showActionSheet() {
//   FlutterCarplay.showActionSheet(
//     template: CPActionSheetTemplate(
//       title: "Action Sheet Template",
//       message: "This is an example message.",
//       actions: [
//         CPAlertAction(
//           title: "Cancel",
//           style: CPAlertActionStyles.cancel,
//           onPress: () {
//             print("Cancel pressed in action sheet");
//             FlutterCarplay.popModal(animated: true);
//           },
//         ),
//         CPAlertAction(
//           title: "Dismiss",
//           style: CPAlertActionStyles.destructive,
//           onPress: () {
//             print("Dismiss pressed in action sheet");
//             FlutterCarplay.popModal(animated: true);
//           },
//         ),
//         CPAlertAction(
//           title: "Ok",
//           style: CPAlertActionStyles.normal,
//           onPress: () {
//             print("Ok pressed in action sheet");
//             FlutterCarplay.popModal(animated: true);
//           },
//         ),
//       ],
//     ),
//   );
// }

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
    FlutterCarplay.push(template: CPNowPlayingTemplate());
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
