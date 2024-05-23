import 'package:delo_automotive/repository/podcast_list_model.dart';
import 'package:delo_automotive/repository/podcast_repo.dart';
import 'package:delo_automotive/screens/podcast_screen.dart';
import 'package:flutter/material.dart';

Widget categoryListTile(BuildContext context, {required String title, required String categoryID}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 2),
    child: ListTile(
      onTap: () async {
        print("in list");
        PodcastListData? podcast;
        await PodcastRepository()
            .getPodcastList(categoryID)
            .then((data) {
          podcast = data;
          print("got podcast $podcast");
          if(podcast != null) {
            print("full podcast");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PodcastScreen(podcastList: podcast!, categoryName: title,),
              ),
            );
          }
        });
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
