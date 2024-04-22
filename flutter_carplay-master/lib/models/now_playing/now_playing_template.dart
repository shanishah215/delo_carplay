import 'package:flutter_carplay/models/button/bar_button.dart';
import 'package:flutter_carplay/models/list/list_section.dart';
import 'package:uuid/uuid.dart';

/// A template object that displays and manages a list of items.
class CPNowPlayingTemplate {
  final String _elementId = const Uuid().v4();
  final String? title;

  CPNowPlayingTemplate({this.title});

  Map<String, dynamic> toJson() => {
        "_elementId": _elementId,
        "title": title,

      };

  String get uniqueId {
    return _elementId;
  }
}
