import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../common/app_setting.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../controller/faq_data.dart';
import '../model/faq_model.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State createState() => _FAQPageState();
}

class _FAQPageState extends State<FaqScreen> {
  bool loading = false;
  List<FaqModel> list = [];
  late double screenWidthAdjustment;

  @override
  void initState() {
    loading = true;
    super.initState();
    getFaqList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Left and Right margins 24 + 24 = 48.0 - Text Left and Right Padding 32 + 32 = 64
    screenWidthAdjustment = MediaQuery.of(context).size.width - 48.0 - 64.0;
  }

  void getFaqList() async {
    FaqData data = FaqData();
    await data.getCallUsList();
    setState(() {
      loading = false;
      list = data.list;
    });
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
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "FAQ",
        colorTitle: Colors.white,
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: loading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return StickyHeader(
                  header: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      //height: height*0.2,
                      color: Colors.indigo[900],
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        list[index].question,
                        style: TextStyle(
                          fontSize: height * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      clipBehavior: Clip.antiAlias,
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 8.0),
                        child: Column(
                          children: List<int>.generate(1, (index) => index)
                              .map(
                                (item) => Html(
                                  //style: TextStyle(fontSize: height*0.025),
                                  style: {
                                    "table": Style(
                                      backgroundColor: const Color.fromARGB(
                                          0x50, 0xee, 0xee, 0xee),
                                    ),
                                    "tr": Style(
                                      border: const Border(
                                          bottom:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                    "th": Style(
                                      //padding:const EdgeInsets.all(6),
                                      backgroundColor: Colors.grey,
                                    ),
                                    "td": Style(
                                      //padding: const EdgeInsets.all(6),
                                      alignment: Alignment.topLeft,
                                    ),
                                    'h5': Style(
                                        maxLines: 2,
                                        textOverflow: TextOverflow.ellipsis),
                                  },

                                  data: list[index].answer,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
