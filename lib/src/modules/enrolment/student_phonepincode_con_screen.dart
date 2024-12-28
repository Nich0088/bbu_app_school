import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/src/modules/enrolment/student_manageenrollment_data.dart';
import 'package:school_app/src/modules/enrolment/student_phonepin_con_req.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentPhonePincodeConnScreen extends StatefulWidget {
  const StudentPhonePincodeConnScreen({super.key});

  @override
  State createState() => _StudentPhonePincodeConnScreenState();
}

class _StudentPhonePincodeConnScreenState
    extends State<StudentPhonePincodeConnScreen> {
  bool loading = false;
  final TextEditingController _textEditphone = TextEditingController();
  final TextEditingController _textEditPincode = TextEditingController();
  static final GlobalKey<FormState> _keyValidationPhonePin =
      GlobalKey<FormState>();

  @override
  void initState() {
    _onLoading();
    //this.getStudentMangeEnrollment();
    super.initState();
  }

  void _onLoading() {
    setState(() {
      loading = true;
      Future.delayed(const Duration(seconds: 3), _login);
    });
  }

  Future _login() async {
    setState(() {
      loading = false;
    });
  }

  Future<void> onConnect() async {
    var sharePre = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    StudentMangeEnrollData data = StudentMangeEnrollData();
    StudentPhonePinConReq req = StudentPhonePinConReq(
        phone: _textEditphone.text, pincode: _textEditPincode.text);

    final result = await data.requestConnectPhonePin(req);
    if (result.studenttemid != "") {
      await sharePre.setString("studentTem_id", result.studenttemid);
      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const HomeScreen(
      //       isRegister: false,
      //       logout: false,
      //     ),
      //   ),
      // );
    } else {
      showMyDialogOnly("${result.message} is error! ", "Failded");
    }
  }

  @override
  void dispose() {
    //   // print("Disposing login");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.026;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.066,
          backgroundColor: Colors.indigo[900],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: height * 0.03,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Phone Pincode to Connect'.tr().toString(),
            style: TextStyle(fontSize: fontsize),
          ),
          centerTitle: true,
        ),
        body: loading
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: height * 0.06,
                ),
              )
            : Form(
                key: _keyValidationPhonePin,
                child: Container(
                  padding: const EdgeInsets.only(left: 15, top: 25, right: 16),
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 100),
                    children: [
                      // Text(
                      //   "Edit Profile",
                      //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      // ),
                      const SizedBox(
                        width: 15,
                      ),
                      /* Center(

                  child: Stack(
                    children: [
                      Container(
                        //padding:EdgeInsets.only(bottom: 100),
                        width:height*0.18 ,
                        height: height*0.18,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              //image: MemoryImage(bytes), fit: BoxFit.cover),
                              image:new  NetworkImage(studentInfoPayRes.studentInfo.photoUrl),
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ],
                  ),
                ), */
                      const SizedBox(
                        height: 70,
                      ),

                      TextFormField(
                        style: TextStyle(fontSize: fontsize),
                        controller: _textEditphone,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: _validatephone,
                        decoration: InputDecoration(
                            labelText: 'phone'.tr().toString(),
                            errorStyle: TextStyle(fontSize: fontsize),
                            //prefixIcon: Icon(Icons.email),
                            icon: Icon(
                              Icons.phone_iphone_outlined,
                              size: fontsize,
                            )),
                      ),

                      //pincode
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3, top: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: fontsize),
                          controller: _textEditPincode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: _validatepincode,
                          decoration: InputDecoration(
                              labelText: 'pincode'.tr().toString(),
                              errorStyle: TextStyle(fontSize: fontsize),
                              //prefixIcon: Icon(Icons.email),
                              icon: Icon(
                                Icons.code_outlined,
                                size: fontsize,
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 3, top: 20),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue[900],
                            disabledForegroundColor:
                                Colors.grey.withOpacity(0.38),
                          ),
                          onPressed: () {
                            //print('Pressed');
                            if (_keyValidationPhonePin.currentState!
                                .validate()) {
                              onConnect();
                            }
                          },
                          child: Text(
                            'connect'.tr().toString(),
                            style: TextStyle(fontSize: fontsize),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  ///dailog
  Future<void> showMyDialogOnly(String sms, String title) async {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.03;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: fontsize),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  sms,
                  style: TextStyle(fontSize: fontsize),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('close'.tr(), style: TextStyle(fontSize: fontsize)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String? _validatephone(String? value) {
    return value!.trim().isEmpty
        ? "phone".tr().toString() + " can not be empty".tr().toString()
        : null;
  }

  String? _validatepincode(String? value) {
    return value!.trim().isEmpty
        ? 'pincode'.tr().toString() + " can not be empty".tr().toString()
        : null;
  }
}

Widget buildTextFileEdit(
    String labelText, String placeholder, double fontsize) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3, top: 20),
    child: TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 3),
        labelText: labelText,
        labelStyle: TextStyle(fontSize: fontsize),
        enabled: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    ),
  );
}
