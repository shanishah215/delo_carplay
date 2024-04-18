import 'package:delo_automotive/screens/media_player.dart';
import 'package:flutter/material.dart';

Widget categoryListTile(BuildContext context, {required String title}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 2),
    child: ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MediaPlayer(continuePlaying: false,),
            ));
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Theme.of(context).listTileTheme.tileColor,
      title: Text(
        title,
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        size: 30,
        color: Theme.of(context).listTileTheme.titleTextStyle!.color,
      ),
    ),
  );
}
