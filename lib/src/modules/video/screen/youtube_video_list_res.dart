class YoutubeVideoByListId {
  YoutubeVideoByListId({
    required this.kind,
    required this.etag,
    this.prevPageToken,
    this.nextPageToken,
    required this.items,
    required this.pageInfo,
  });

  String kind;
  String etag;
  String? prevPageToken;
  String? nextPageToken;

  List<ItemVideo> items;
  PageInfoVideo pageInfo;

  factory YoutubeVideoByListId.fromJson(Map<String, dynamic> json) =>
      YoutubeVideoByListId(
        kind: json["kind"],
        etag: json["etag"],
        prevPageToken: json["prevPageToken"],
        nextPageToken: json["nextPageToken"],
        items: json["items"] != null
            ? List<ItemVideo>.from(
                json["items"].map((x) => ItemVideo.fromJson(x)))
            : [],
        pageInfo: PageInfoVideo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "prevPageToken": prevPageToken,
        "nextPageToken": nextPageToken,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pageInfo": pageInfo.toJson(),
      };
}

class ItemVideo {
  ItemVideo({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
  });

  String kind;
  String etag;
  String id;
  SnippetVideo snippet;

  factory ItemVideo.fromJson(Map<String, dynamic> json) => ItemVideo(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        snippet: SnippetVideo.fromJson(json["snippet"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet.toJson(),
      };
}

class SnippetVideo {
  SnippetVideo({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.playlistId,
    required this.position,
    required this.resourceId,
    required this.videoOwnerChannelTitle,
    required this.videoOwnerChannelId,
  });

  DateTime publishedAt;
  String channelId;
  String title;
  String description;
  ThumbnailsVideo thumbnails;
  String channelTitle;
  String playlistId;
  int position;
  ResourceId resourceId;
  String videoOwnerChannelTitle;
  String videoOwnerChannelId;

  factory SnippetVideo.fromJson(Map<String, dynamic> json) => SnippetVideo(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: ThumbnailsVideo.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        playlistId: json["playlistId"],
        position: json["position"],
        resourceId: ResourceId.fromJson(json["resourceId"]),
        videoOwnerChannelTitle: json["videoOwnerChannelTitle"],
        videoOwnerChannelId: json["videoOwnerChannelId"],
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails.toJson(),
        "channelTitle": channelTitle,
        "playlistId": playlistId,
        "position": position,
        "resourceId": resourceId.toJson(),
        "videoOwnerChannelTitle": videoOwnerChannelTitle,
        "videoOwnerChannelId": videoOwnerChannelId,
      };
}

class ResourceId {
  ResourceId({
    required this.kind,
    required this.videoId,
  });

  String kind;
  String videoId;

  factory ResourceId.fromJson(Map<String, dynamic> json) => ResourceId(
        kind: json["kind"],
        videoId: json["videoId"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "videoId": videoId,
      };
}

class ThumbnailsVideo {
  ThumbnailsVideo({
    this.thumbnailsDefault,
    this.medium,
    this.high,
    this.standard,
    this.maxres,
  });

  DefaultVideo? thumbnailsDefault;
  DefaultVideo? medium;
  DefaultVideo? high;
  DefaultVideo? standard;
  DefaultVideo? maxres;

  factory ThumbnailsVideo.fromJson(Map<String, dynamic> json) =>
      ThumbnailsVideo(
        thumbnailsDefault: json["medium"] != null
            ? DefaultVideo.fromJson(json["default"])
            : null,
        medium: json["medium"] != null
            ? DefaultVideo.fromJson(json["medium"])
            : null,
        high: json["high"] != null ? DefaultVideo.fromJson(json["high"]) : null,
        standard: json["standard"] != null
            ? DefaultVideo.fromJson(json["standard"])
            : null,
        maxres: json["maxres"] != null
            ? DefaultVideo.fromJson(json["maxres"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault?.toJson(),
        "medium": medium?.toJson(),
        "high": high?.toJson(),
        "standard": standard?.toJson(),
        "maxres": maxres?.toJson(),
      };
}

class DefaultVideo {
  DefaultVideo({
    required this.url,
    required this.width,
    required this.height,
  });

  String url;
  int width;
  int height;

  factory DefaultVideo.fromJson(Map<String, dynamic> json) => DefaultVideo(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class PageInfoVideo {
  PageInfoVideo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  int totalResults;
  int resultsPerPage;

  factory PageInfoVideo.fromJson(Map<String, dynamic> json) => PageInfoVideo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
      };
}
