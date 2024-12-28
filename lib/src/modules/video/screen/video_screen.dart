import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/src/modules/video/screen/video_accesskey_data.dart';
import 'package:school_app/src/modules/video/screen/youtube_data.dart';
import 'package:school_app/src/modules/video/screen/youtube_playvideo_inlist_page.dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../videoaccess/video_access_req.dart';
import '../../videoaccess/video_access_res.dart';
import '../../videoaccess/youtube_res.dart';

// import 'package:youtube_api/youtube_api.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VidesPageState();
}

class _VidesPageState extends State<VideoScreen> {
  //static String key = "4642c19f11c25867a3869a3dee7d05e2dd201166";
  //static String defaultkey = "AIzaSyARciD_B__JlQ2Q8HZ99vlL3m4ABSEA8EQ";
  List<VideoAccessKeyDataList> videoAccKeyDataList = [];
  bool loading = false;

  //List<VideoModel> list = [];
  //double _screenWidthAdjustment;
  //YoutubeAPI ytApi = YoutubeAPI(key);
  //List<YouTubeVideo> ytResult = [];
  //List<YT_API> ytResult = [];
  //int _selectedIndex = 0;
  //////new
  ///
  //late YoutubePlayerController _controller;

  YoutubeRes resultYoutubeRes = YoutubeRes(
      kind: "",
      etag: "",
      pageInfo: PageInfo(totalResults: 0, resultsPerPage: 0),
      items: []);

  ///
  ///end new
  _onSelected(int index) {
    //setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    loading = true;
    getBaseUrl();

    super.initState();
    //this.getVideoList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Left and Right margins 24 + 24 = 48.0 - Text Left and Right Padding 32 + 32 = 64
    //_screenWidthAdjustment = MediaQuery.of(context).size.width - 48.0 - 64.0;
  }

  /* void getVideoList() async {
    VideoData data = VideoData();
    await data.getList();

    setState(() {
      loading = false;
      list = data.list;
    });
  } */
  Future<void> getBaseUrl() async {
    List<VideoAccessKeyDataList> temAllListData1 = [];
    VideoAccessKeyData data = VideoAccessKeyData();

    final result = await data.getDataBaseKey();
    if (result.code == 200) {
      temAllListData1 = result.dataList;
    }
    //else {}
    setState(() {
      videoAccKeyDataList = temAllListData1;
    });
    getListVideoYoutube();
    loading = false;
  }

  void getListVideoYoutube() async {
    final sharedPref = await SharedPreferences.getInstance();
    YoutubeData youtubeData = YoutubeData();

    if (videoAccKeyDataList.isNotEmpty) {
      var accKey = videoAccKeyDataList[0];
      VideoAccessKeyReq req = VideoAccessKeyReq(
          id: 0,
          accessName: "",
          urlBase: accKey.urlBase,
          channelidKey1: accKey.channelidKey1,
          key2: accKey.key2,
          key3: "");

      var result = await youtubeData.getAllPlaylistYoutube(req);

      await sharedPref.setString("accessName", accKey.accessName);
      await sharedPref.setString("accchannelidKey1", accKey.channelidKey1);
      await sharedPref.setString("accessurlBase", accKey.urlBase);
      await sharedPref.setString("accesskey2", accKey.key2);
      //await sharedPref.setString("accesskey3", accKey.key3);
      //if (mounted){
      setState(() {
        resultYoutubeRes = result;
      });
      //}
      loading = false;
    } else {}
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.03;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.066,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: fontsize,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'video'.tr().toString(),
          style: TextStyle(fontSize: fontsize),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: loading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Container(
                // ignore: unnecessary_null_comparison
                child: resultYoutubeRes != null
                    ? ListView.builder(
                        itemCount: resultYoutubeRes.items.length,
                        itemBuilder: (_, int index) => listItem(index),
                        reverse: true,
                        shrinkWrap: true,
                      )
                    : const Text(""),
              ),
      ),
    );
  }

  Widget listItem(index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.03;
    //double padTop=height*0.01;
    var listV = resultYoutubeRes.items;
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => YoutubePlayVideoInListPage(
                  playlistId: listV[index].id,
                  playlistTitle: listV[index].snippet.title),
            ),
          );
          _onSelected(index);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //clipBehavior: Clip.antiAlias,
            elevation: 5,
            child: Container(
              /* color: _selectedIndex != null && _selectedIndex == index
                  ? Colors.black26
                  : Colors.white, */
              margin: const EdgeInsets.symmetric(vertical: 3.0),

//        padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    /* image: "https://i.ytimg.com/vi/" +
                        list[index].youtubeId +
                        "/default.jpg", */
                    image: listV[index].snippet.thumbnails.high.url,
                    fit: BoxFit.fill,
                    width: width * 0.3,
                    height: height * 0.15,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 20.0)),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Text(
                          listV[index].snippet.title,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.black),
                        ),
                      ]))
                ],
              ),
            ),
          ),
        ));
  }
}
