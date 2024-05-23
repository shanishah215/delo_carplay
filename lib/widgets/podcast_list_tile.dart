import 'package:delo_automotive/repository/podcast_list_model.dart';

import '../screens/media_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget podcastListTile(BuildContext context, {required String title, required Playlist? playlist, required String categoryName}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 2),
    child: ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MediaPlayer(
                continuePlaying: false,
                playlist: playlist,
                categoryName: categoryName,
              ),
            ));
      },
      leading: Container(
          margin: const EdgeInsets.only(
            right: 20,
          ),
          height: 80,
          width: 144,
          child: Image.network(playlist?.images?[0].src ?? "")),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Theme.of(context).listTileTheme.tileColor,
      title: Text(
        playlist?.title ?? "",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      subtitle: Text(
        playlist?.description ?? "",
        style: Theme.of(context).listTileTheme.subtitleTextStyle,
      ),
    ),
  );
}
