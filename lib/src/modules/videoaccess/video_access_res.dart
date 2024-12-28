
class VideoAccessKeyRes {
    VideoAccessKeyRes({
     required   this.code,
     required   this.message,
     required   this.dataList,
    });

    int code;
    String message;
    List<VideoAccessKeyDataList> dataList;

    factory VideoAccessKeyRes.fromJson(Map<String, dynamic> json) => VideoAccessKeyRes(
        code: json["code"],
        message: json["message"],
        dataList: List<VideoAccessKeyDataList>.from(json["data"].map((x) => VideoAccessKeyDataList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(dataList.map((x) => x.toJson())),
    };
}

class VideoAccessKeyDataList {
    VideoAccessKeyDataList({
      required  this.id,
      required  this.accessName,
      required  this.urlBase,
      required  this.channelidKey1,
      required  this.key2,
        this.key3,
    });

    int id;
    String accessName;
    String urlBase;
    String channelidKey1;
    String key2;
    String? key3;

    factory VideoAccessKeyDataList.fromJson(Map<String, dynamic> json) => VideoAccessKeyDataList(
        id: json["id"],
        accessName: json["access_name"],
        urlBase: json["url_base"],
        channelidKey1: json["channelid_key1"],
        key2: json["key2"],
        key3: json["key3"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "access_name": accessName,
        "url_base": urlBase,
        "channelid_key1": channelidKey1,
        "key2": key2,
        "key3": key3,
    };
}
