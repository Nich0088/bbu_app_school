import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_app/src/modules/video/screen/youtube_data.dart';
import 'package:school_app/src/modules/video/screen/youtube_video_list_res.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../videoaccess/video_access_req.dart';
import 'onloading_widget.dart';

class YoutubePlayVideoInListPage extends StatefulWidget {
  const YoutubePlayVideoInListPage(
      {super.key, required this.playlistId, required this.playlistTitle});

  final String playlistId;
  final String playlistTitle;

  @override
  State<YoutubePlayVideoInListPage> createState() =>
      _YoutubePlayVideoInListPageState();
}

class _YoutubePlayVideoInListPageState
    extends State<YoutubePlayVideoInListPage> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  //String urlYoutube = "https://youtu.be/UUrDfU3vvro";
  String videiIdGlobal = "UUrDfU3vvro";
  String titleProductPlay = "";
  bool loading = false;
  String authenticateToken = "";

  late TextEditingController _idController;
  late TextEditingController _seekToController;
  String pageToken = "";
  String nextPageToken = "";
  String prevPageToken = "";
  ScrollController sc = ScrollController();
  final List<String> _ids = [];
  final List<String> _vdTitles = [];

  //List<YoutubeVideoByListId> youtubeVideoByList= [];
  List<ItemVideo> itemVideoList = [];
  List<Widget> widgetsListVideos = [];

  bool _muted = false;
  int selectedindex = 0, totalResults = 1;
  final Color _containerColor = Colors.white;

  ResourceId resourceIdFirst =
      ResourceId(kind: "youtube#video", videoId: "UUrDfU3vvro");

  @override
  void initState() {
    loading = true;

    getListVideoYoutubeInList();

    //_ids.add('UUrDfU3vvro');
    //_vdTitles.add('Video Ttile 1');
    super.initState();

    _idController = TextEditingController();
    _seekToController = TextEditingController();

    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        getListVideoYoutubeInList();
      }
    });
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();

    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  void getListVideoYoutubeInList() async {
    final sharedPref = await SharedPreferences.getInstance();
    //String accessName  = sharedPref.getString("accessName");
    String accchannelidKey1 = sharedPref.getString("accchannelidKey1")!;
    String accessurlBase = sharedPref.getString("accessurlBase")!;
    String accesskey2 = sharedPref.getString("accesskey2")!;
    // String accesskey3  = sharedPref.getString("accesskey2");

    VideoAccessKeyReq req = VideoAccessKeyReq(
        id: 0,
        accessName: "",
        urlBase: accessurlBase,
        channelidKey1: accchannelidKey1,
        key2: accesskey2,
        key3: "");

    YoutubeData youtubeData = YoutubeData();
    var playlistIdTem = widget.playlistId;

    var result = await youtubeData.getAllVideoInPlaylist(
        req, playlistIdTem, 10, pageToken);
    List<String> ids1 = [];
    List<String> vdTitles1 = [];
    List<ItemVideo> itemVideoList1 = [];
    String titleProductPlay1 = "";
    int totalResults1 = totalResults;
    //////////
    ///
    itemVideoList1 = result.items;

    ///////////
    if (result.nextPageToken != null) {
      var firstItem = result.items[0].snippet.title;
      titleProductPlay1 = firstItem;
      videiIdGlobal = result.items[0].snippet.resourceId.videoId;
      for (var item in result.items) {
        var videoid1 = item.snippet.resourceId.videoId;
        ids1.add(videoid1);
        vdTitles1.add(item.snippet.title);
      }
    } else {
      ids1.add('UUrDfU3vvro');
      vdTitles1.add('Video Ttile 1');
      //titleProductPlay1="UUrDfU3vvro";
      //videiIdGlobal1="";
    }

    //if (mounted){
    setState(() {
      //videiIdGlobal=videiIdGlobal1;
      //titleProductPlay=titleProductPlay1;
      loading = false;

      ///////////////
      ///

      itemVideoList.addAll(itemVideoList1);
      _ids.addAll(ids1);
      _vdTitles.addAll(vdTitles1);
      nextPageToken = result.nextPageToken ?? "";
      prevPageToken = result.prevPageToken ?? "";
      if (result.nextPageToken != null) {
        pageToken = result.nextPageToken ?? "";
      }

      totalResults = result.pageInfo.totalResults;

      //videiIdGlobal = getYoutubeVideoId(urlYoutube)!;

      ///
      ///
    });
    if (totalResults1 == 1) {
      titleProductPlay = titleProductPlay1;
      _controller = YoutubePlayerController(
        initialVideoId: videiIdGlobal,
        flags: const YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: true,
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(_listener);
      _isPlayerReady = false;
      _controller.load(videiIdGlobal);
    }
  }

  Widget buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: loading ? 10.0 : 10.0,
          child: const CupertinoActivityIndicator(),
        ),
      ),
    );
    //print("===");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    double fontsize = height * 0.02;
    return loading
        ? /* Center(
                child: CupertinoActivityIndicator(radius: height*0.06,),
              ) */
        onLoadingWidget(context)
        :
        //Container(child: Text(""),);
        YoutubePlayerBuilder(
            onExitFullScreen: () {
              // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              width: width,
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _controller.metadata.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.02,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: fontsize,
                  ),
                  onPressed: () {
                    log('Settings Tapped!');
                  },
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                var indV = (_ids.indexOf(videiIdGlobal) + 1) % _ids.length;
                if (indV == _ids.length - 1) {
                  indV = 0;
                }
                _controller.load(_ids[indV]);
                setState(() {
                  titleProductPlay = _vdTitles[indV];

                  videiIdGlobal = _ids[indV];
                });
                // _showSnackBar('Next Video Started!');
              },
            ),
            builder: (context, player) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigo[900],
                toolbarHeight: height * 0.066,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: /* Image.asset(
              'assets/logo.png',
              fit: BoxFit.fitWidth,
            ), */

                      IconButton(
                    iconSize: height * 0.03,
                    icon: const Icon(Icons.arrow_back_ios),
                    tooltip: 'Back ',
                    onPressed: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown
                      ]);
                      Navigator.pop(context);
                      /*  Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyHomePageDelivery())); */
                    },
                  ),
                ),
                title: Text(
                  //widget.productList.productname ,
                  titleProductPlay,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                actions: [
                  IconButton(
                    iconSize: height * 0.03,
                    icon: const Icon(Icons.home_filled),
                    highlightColor: Colors.pink,
                    onPressed: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown
                      ]);
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => const HomeScreen(
                      //           isRegister: false,
                      //           logout: false,
                      //         )));
                    },
                  ),
                ],
              ),
              body: ListView(children: [
                player,
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                iconSize: fontsize,
                                icon: const Icon(Icons.skip_previous),
                                onPressed: _isPlayerReady
                                    ? () {
                                        var indV =
                                            (_ids.indexOf(videiIdGlobal) - 1) %
                                                _ids.length;
                                        if (indV == _ids.length - 1) {
                                          indV = 0;
                                        }
                                        _controller.load(_ids[indV]);
                                        setState(() {
                                          titleProductPlay = _vdTitles[indV];

                                          videiIdGlobal = _ids[indV];
                                        });
                                      }
                                    : null,
                              ),
                              IconButton(
                                iconSize: fontsize,
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                onPressed: _isPlayerReady
                                    ? () {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                        setState(() {});
                                      }
                                    : null,
                              ),
                              IconButton(
                                iconSize: fontsize,
                                icon: Icon(_muted
                                    ? Icons.volume_off
                                    : Icons.volume_up),
                                onPressed: _isPlayerReady
                                    ? () {
                                        _muted
                                            ? _controller.unMute()
                                            : _controller.mute();
                                        setState(() {
                                          _muted = !_muted;
                                        });
                                      }
                                    : null,
                              ),
                              FullScreenButton(
                                controller: _controller,
                                color: Colors.blueAccent,
                              ),
                              IconButton(
                                iconSize: fontsize,
                                icon: const Icon(Icons.skip_next),
                                onPressed: _isPlayerReady
                                    ? () {
                                        var indV =
                                            (_ids.indexOf(videiIdGlobal) + 1) %
                                                _ids.length;
                                        if (indV == _ids.length - 1) {
                                          indV = 0;
                                        }
                                        _controller.load(_ids[indV]);
                                        setState(() {
                                          titleProductPlay = _vdTitles[indV];

                                          videiIdGlobal = _ids[indV];
                                        });
                                      }
                                    : null,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: height / 2,
                            //height: 200 ,

                            child: /* SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child:Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: getListVideos(),
                  ),
                ), */

                                ListView.builder(
                              //itemExtent: height*0.52,
                              itemCount: itemVideoList.length,
                              itemBuilder: (BuildContext context, int index) {
                                int index1 = index + 1;
                                if (index == itemVideoList.length) {
                                  return buildProgressIndicator();
                                } else {
                                  ///////
                                  String videiId = "";
                                  String imageUrl = "";
                                  var thum1 = itemVideoList[index]
                                      .snippet
                                      .thumbnails
                                      .thumbnailsDefault;

                                  String urlimg = "";
                                  if (thum1 != null) {
                                    urlimg = thum1.url;
                                    videiId = itemVideoList[index]
                                        .snippet
                                        .resourceId
                                        .videoId;
                                  }

                                  if (urlimg != "") {
                                    imageUrl = urlimg;
                                  } else {
                                    //default no image
                                    imageUrl =
                                        "https://bbu.edu.kh/bbu_app/assets/images/no-image2.jpg";
                                  }
                                  return GestureDetector(
                                    // when user is pressing
                                    onTapDown: (details) {
                                      videiId = videiId = itemVideoList[index]
                                          .snippet
                                          .resourceId
                                          .videoId;
                                      setState(() {
                                        videiIdGlobal = videiId;
                                        titleProductPlay =
                                            itemVideoList[index].snippet.title;
                                        _controller.load(videiId);
                                      });
                                    },
                                    // when user leaved
                                    onTapUp: (details) {
                                      setState(() {});
                                    },
                                    // when user leaved
                                    onTapCancel: () {
                                      setState(() {});
                                    },
                                    // the action to do when user tap
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Card(
                                        child: Container(
                                      color: titleProductPlay ==
                                              itemVideoList[index].snippet.title
                                          ? _containerColor
                                          : Colors.white,
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              //width: width,
                                              width: width * 0.3,
                                              height: height * 0.15,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(imageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(children: <Widget>[
                                                //Text("This example shows a Scaffold with an AppBar, a Bottom AppBar and a Floating Action Button. The body is a Text placed in ."),
                                                //Text(item.productname),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    /* item.snippet.title==null
                                ?""
                                :item.snippet.title.length>30
                                ?item.snippet.title.substring(0,30)
                                :item.snippet.title, */
                                                    "$index1-${itemVideoList[index].snippet.title}",
                                                    style: TextStyle(
                                                        fontSize: itemVideoList[
                                                                        index]
                                                                    .snippet
                                                                    .title
                                                                    .length >
                                                                40
                                                            ? height * 0.015
                                                            : height * 0.02,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // ignore: unnecessary_null_comparison
                                                Text(
                                                  // ignore: unnecessary_null_comparison
                                                  itemVideoList[index]
                                                              .snippet
                                                              .description ==
                                                          null
                                                      ? ""
                                                      : itemVideoList[index]
                                                                  .snippet
                                                                  .description
                                                                  .length >
                                                              40
                                                          ? itemVideoList[index]
                                                              .snippet
                                                              .description
                                                              .substring(0, 40)
                                                          : itemVideoList[index]
                                                              .snippet
                                                              .description,
                                                  style: TextStyle(
                                                    //color: Colors.red,

                                                    fontSize: height * 0.02,
                                                    //fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                  );
                                }
                              },
                              controller: sc,
                            ),
                          )
                        ]))
              ]),
            ),
          );
  }
}
