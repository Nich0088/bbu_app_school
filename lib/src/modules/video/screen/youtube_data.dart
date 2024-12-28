import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school_app/src/modules/video/screen/youtube_video_list_res.dart';

import '../../videoaccess/video_access_req.dart';
import '../../videoaccess/youtube_res.dart';

class YoutubeData {
  late YoutubeRes resultRequest;

  Future<YoutubeRes> getAllPlaylistYoutube(VideoAccessKeyReq req) async {
    VideoAccessKeyReq createReq = req;
    if (createReq.channelidKey1 == "") {
      createReq.channelidKey1 = "UCfH0lXn0wAQ23b0ktiw7K7A";
    }
    if (createReq.key2 == "") {
      //channelId=UCfH0lXn0wAQ23b0ktiw7K7A&key=AIzaSyCj3CgzWrsz_pZbTcUqImkDO7A5ka35eMw

      createReq.key2 = "AIzaSyCj3CgzWrsz_pZbTcUqImkDO7A5ka35eMw";
    }
    if (req.urlBase == "") {
      createReq.urlBase = "https://youtube.googleapis.com/youtube/";
    }
    var strurl =
        "${createReq.urlBase}v3/playlists?part=snippet&channelId=${createReq.channelidKey1}&key=${createReq.key2}&order=date";

    var url1 = Uri.parse(strurl);
    var response = await http.get(url1);
    if (response.statusCode == 200) {
      final jsonresponse = jsonDecode(response.body);
      resultRequest = YoutubeRes.fromJson(jsonresponse);
    }
    return resultRequest;
  }

  late YoutubeVideoByListId resultYoutubeVideoByListId;

  Future<YoutubeVideoByListId> getAllVideoInPlaylist(VideoAccessKeyReq req,
      String playlistId, int maxResults, String pageToken) async {
    VideoAccessKeyReq createReq = req;
    if (playlistId == "") {
      playlistId = "PLHjZAG3mi5X1YOusZ5ISd3vDHYyP6MURc";
    }
    if (createReq.key2 == "") {
      //channelId=UCfH0lXn0wAQ23b0ktiw7K7A&key=AIzaSyCj3CgzWrsz_pZbTcUqImkDO7A5ka35eMw
      createReq.key2 = "AIzaSyCj3CgzWrsz_pZbTcUqImkDO7A5ka35eMw";
    }
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (maxResults == null) {
      maxResults = 10;
    }
    if (req.urlBase == "") {
      createReq.urlBase = "https://youtube.googleapis.com/youtube/";
    }
    //playlistItems?part=snippet&maxResults=25&playlistId=
    var strurl =
        "${createReq.urlBase}v3/playlistItems?part=snippet&maxResults=$maxResults&playlistId=$playlistId&key=${createReq.key2}&pageToken=$pageToken";

    var url1 = Uri.parse(strurl);
    var response = await http.get(url1);
    if (response.statusCode == 200) {
      final jsonresponse = jsonDecode(response.body);
      resultYoutubeVideoByListId = YoutubeVideoByListId.fromJson(jsonresponse);
    }
    return resultYoutubeVideoByListId;
  }
}
