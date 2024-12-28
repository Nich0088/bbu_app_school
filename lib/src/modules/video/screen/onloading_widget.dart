import 'package:flutter/material.dart';

Widget onLoadingColorBackWidget(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Stack(
      children: <Widget>[
        // body,
        Container(
          //color: Colors.blue[300],
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(
            color: Colors.white70,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[300],
              //borderRadius: new BorderRadius.circular(20.0)
            ),
            /* width: 300.0,
                    height: 150.0, */
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: Image.asset(
                    "assets/bbu_splash_screen.png",
                    height: 200,
                  )

                      /* new Text(
                              "BODI CENTER ",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                decoration: TextDecoration.none,
                              ),
                            ), */
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget onLoadingWidget(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  //var fontsize=height*0.03;
  return Container(
    color: Colors.white,
    child: Stack(
      children: <Widget>[
        // body,
        Container(
          //color: Colors.blue[300],
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(
            color: Colors.white70,
          ),
          child: Container(
            decoration: const BoxDecoration(
                //color: Colors.blue[300],
                //borderRadius: new BorderRadius.circular(20.0)
                ),
            /* width: 300.0,
                    height: 150.0, */
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: Image.asset(
                    "assets/dashboard/bbu-1.png",
                    height: height * 0.5,
                    //width: width*0.7,
                  )

                      /* new Text(
                              "BODI CENTER ",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                decoration: TextDecoration.none,
                              ),
                            ), */
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    height: height * 0.1,
                    width: width * 0.1,
                    child: const CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
