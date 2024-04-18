import 'dart:convert';

import 'package:delo_automotive/repository/podcast_list_model.dart';
import 'package:delo_automotive/repository/podcast_menu_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PodcastRepository {


  Future<List<PodcastMenuModel>> getPodcastCategories() async {
    List<PodcastMenuModel> podcastMenuList = [];

    String url = "https://cdn.jwplayer.com/apps/configs/t48tzaqu.json";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final podcastMenuJson = jsonDecode(response.body) as Map<String, dynamic>;
        List contentList = podcastMenuJson['content'];
        podcastMenuList = contentList.map((e) {
          return PodcastMenuModel.fromJson(e);
        }).toList();
      }
    } catch (e) {
      debugPrint("error $e");
    }
    return podcastMenuList;
  }

  Future<PodcastListData?> getPodcastList(String categoryID) async {
    PodcastListData? podcastData;

    String url = "https://cdn.jwplayer.com/v2/playlists/$categoryID?format=json";
    try {
      http.Response response = await http.get(Uri.parse(url));
      // debugPrint("podcast List ${response.body}");
      if (response.statusCode == 200) {
        final podcastJson = jsonDecode(response.body) as Map<String, dynamic>;
        podcastData = PodcastListData.fromJson(podcastJson);
      }
    } catch (e) {
      debugPrint("error $e");
    }
    return podcastData;
  }
}
