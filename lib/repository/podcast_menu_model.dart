class PodcastMenuModel {
  final String contentId;
  final bool enableText;
  final bool featured;
  final String title;
  final String type;

  PodcastMenuModel({required this.contentId, required this.enableText, required this.featured, required this.title, required this.type});

  factory PodcastMenuModel.fromJson(Map data) {
    return PodcastMenuModel(
        contentId: data['contentId'].toString(),
        enableText: data['enableText'],
        featured: data['featured'],
        title: data['title'].toString(),
        type: data['type'].toString()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contentId' : contentId,
      'enableText': enableText,
      'featured' : featured,
      'title' : title,
      'type' : type
    };
  }
}