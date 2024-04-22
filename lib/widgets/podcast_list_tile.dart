import '../screens/media_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget podcastListTile(BuildContext context, {required String title}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 2),
    child: ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MediaPlayer(
                continuePlaying: false,
              ),
            ));
      },
      leading: Container(
          margin: const EdgeInsets.only(
            right: 20,
          ),
          height: 80,
          width: 144,
          child: SvgPicture.asset(
            'assets/images/podcast_img.svg',
            height: 80,
            width: 144,
            fit: BoxFit.cover,
          )),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Theme.of(context).listTileTheme.tileColor,
      title: Text(
        title,
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      subtitle: Text(
        'Ali Žerdin in Janez Markeš sta ob okrogli obletnici razpravljala...',
        style: Theme.of(context).listTileTheme.subtitleTextStyle,
      ),
    ),
  );
}
