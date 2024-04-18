class PodcastListData {
  String? title;
  String? description;
  String? kind;
  String? feedid;
  String? link;
  Links? links;
  List<Playlist>? playlist;
  String? feedInstanceId;

  PodcastListData({this.title, this.description, this.kind, this.feedid, this.link, this.links, this.playlist, this.feedInstanceId});

  PodcastListData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    kind = json['kind'];
    feedid = json['feedid'];
    link = json['link'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    if (json['playlist'] != null) {
      playlist = <Playlist>[];
      json['playlist'].forEach((v) {
        playlist!.add(Playlist.fromJson(v));
      });
    }
    feedInstanceId = json['feed_instance_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['kind'] = kind;
    data['feedid'] = feedid;
    data['link'] = link;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (playlist != null) {
      data['playlist'] = playlist!.map((v) => v.toJson()).toList();
    }
    data['feed_instance_id'] = feedInstanceId;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  String? next;

  Links({this.first, this.last, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['next'] = next;
    return data;
  }
}

class Playlist {
  String? title;
  String? mediaid;
  String? link;
  String? image;
  List<Images>? images;
  String? feedid;
  num? duration;
  num? pubdate;
  String? description;
  String? tags;
  List<Sources>? sources;
  List<Tracks>? tracks;

  Playlist(
      {this.title,
      this.mediaid,
      this.link,
      this.image,
      this.images,
      this.feedid,
      this.duration,
      this.pubdate,
      this.description,
      this.tags,
      this.sources,
      this.tracks});

  Playlist.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    mediaid = json['mediaid'];
    link = json['link'];
    image = json['image'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    feedid = json['feedid'];
    duration = json['duration'];
    pubdate = json['pubdate'];
    description = json['description'];
    tags = json['tags'];
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(Sources.fromJson(v));
      });
    }
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks!.add(Tracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['mediaid'] = mediaid;
    data['link'] = link;
    data['image'] = image;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['feedid'] = feedid;
    data['duration'] = duration;
    data['pubdate'] = pubdate;
    data['description'] = description;
    data['tags'] = tags;
    if (sources != null) {
      data['sources'] = sources!.map((v) => v.toJson()).toList();
    }
    if (tracks != null) {
      data['tracks'] = tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? src;
  num? width;
  String? type;

  Images({this.src, this.width, this.type});

  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    width = json['width'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    data['width'] = width;
    data['type'] = type;
    return data;
  }
}

class Sources {
  String? file;
  String? type;
  num? height;
  num? width;
  String? label;
  num? bitrate;
  num? filesize;
  num? framerate;

  Sources({this.file, this.type, this.height, this.width, this.label, this.bitrate, this.filesize, this.framerate});

  Sources.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    type = json['type'];
    height = json['height'];
    width = json['width'];
    label = json['label'];
    bitrate = json['bitrate'];
    filesize = json['filesize'];
    framerate = json['framerate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['type'] = type;
    data['height'] = height;
    data['width'] = width;
    data['label'] = label;
    data['bitrate'] = bitrate;
    data['filesize'] = filesize;
    data['framerate'] = framerate;
    return data;
  }
}

class Tracks {
  String? file;
  String? kind;

  Tracks({this.file, this.kind});

  Tracks.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['kind'] = kind;
    return data;
  }
}
