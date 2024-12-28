
class VideoAccessKeyReq {
    VideoAccessKeyReq({
     required   this.id,
     required   this.accessName,
     required   this.urlBase,
     required   this.channelidKey1,
      required  this.key2,
      required  this.key3,
    });

    int id;
    String accessName;
    String urlBase;
    String channelidKey1;
    String key2;
    String key3;

    factory VideoAccessKeyReq.fromJson(Map<String, dynamic> json) => VideoAccessKeyReq(
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
