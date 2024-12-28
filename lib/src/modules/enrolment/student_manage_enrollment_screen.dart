import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/src/modules/enrolment/student_info_pay_res.dart';
import 'package:school_app/src/modules/enrolment/student_manageenrollment_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentManageEnrollScreen extends StatefulWidget {
  const StudentManageEnrollScreen({super.key});

  @override
  State createState() => _StudentManageEnrollScreenState();
}

class _StudentManageEnrollScreenState extends State<StudentManageEnrollScreen> {
  bool loading = false;

  //StudentInfoPayRes? studentInfoPayRes;
  DataStudentInfo studentInfo = DataStudentInfo(
      studentIdTemp: "",
      studentNameEn: "",
      studentNameKh: "",
      firstNameEn: "",
      firstNameKh: "",
      lastNameEn: "",
      lastNameKh: "",
      sex: "",
      dateOfBirth: DateTime.now(),
      placeOfBirth: "",
      photo: "",
      photoUrl: "",
      phone: "",
      branchNameEn: "",
      branchNameKh: "",
      specializationEn: "",
      specializationKh: "",
      degreeEn: "",
      degreeKh: "",
      facultyEn: "",
      facultyKh: "",
      chooseAcademicPrice: 0,
      studyTime: "");
  StudentPayinfo studentPayinfo = StudentPayinfo(
      paymenTStudentId: 0,
      paymenTGatewaYs: "",
      studenTId: "",
      paYDate: DateTime.now(),
      amount: 0,
      discount: 0.0);

  String urlImage = "http://register.bbu.edu.kh/Images/no-image2.jpg";
  final currencyFormat = NumberFormat("#,##0", "en_US");

  @override
  void initState() {
    loading = true;

    super.initState();
    getStudentMangeEnrollment();
  }

  Future<void> getStudentMangeEnrollment() async {
    var sharePre = await SharedPreferences.getInstance();
    StudentMangeEnrollData data = StudentMangeEnrollData();
    var studentTemId = sharePre.getString("studentTem_id");
    if (studentTemId != null) {
      final result = await data.getDataStudentEnroll(studentTemId);
      if (mounted) {
        setState(() {
          studentInfo = result.studentInfo;
          studentPayinfo = result.studentPayinfo!;

          loading = false;
        });
      }
    }
  }

//http://results.bbu.edu.kh/STUDENTS/GetImage?stid=PP41218
  @override
  void dispose() {
    //   // print("Disposing login");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.02;
    //var studentInfo =studentInfo;
    // var studentPayinfo=studentInfoPayRes!.studentPayinfo;
    var ddd = DateTime.now();
    var paiddateTem = DateTime.now();
    double pricess = 0.0, amount = 0.0;
    String dateofbirth, choosePrice, amountpay, paidate;

    // ignore: unnecessary_null_comparison
    if (studentInfo != null) {
      ddd = studentInfo.dateOfBirth;
      pricess = studentInfo.chooseAcademicPrice;
      amount = studentPayinfo.amount;
      paiddateTem = studentPayinfo.paYDate;
    }
    dateofbirth = DateFormat('dd-MMMM-yyyy').format(ddd);
    paidate = DateFormat('dd-MMMM-yyyy hh:mm a').format(paiddateTem);
    choosePrice = currencyFormat.format(pricess);
    amountpay = currencyFormat.format(amount);

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
            'manageRegisterPay'.tr().toString(),
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
            : Container(
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
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            //padding:EdgeInsets.only(bottom: 100),
                            width: height * 0.18,
                            height: height * 0.18,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  //image: MemoryImage(bytes), fit: BoxFit.cover),
                                  image: NetworkImage(studentInfo.photoUrl!),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),

                    buildTextFileEdit("student_ame".tr().toString(),
                        studentInfo.studentNameEn, fontsize),
                    buildTextFileEdit("student_name_kh".tr().toString(),
                        studentInfo.studentNameKh, fontsize),
                    buildTextFileEdit(
                        "sex".tr().toString(), studentInfo.sex, fontsize),
                    buildTextFileEdit(
                        "dob".tr().toString(), dateofbirth, fontsize),
                    buildTextFileEdit("placeOfBirth".tr().toString(),
                        studentInfo.placeOfBirth, fontsize),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 20),
                      child: Text(
                        "usernamepassword".tr(),
                        style: TextStyle(
                            fontSize: fontsize,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 0),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 3),
                          labelText: "phone".tr().toString(),
                          labelStyle: TextStyle(fontSize: fontsize),
                          enabled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: studentInfo.phone,
                          hintStyle: TextStyle(
                              fontSize: fontsize,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 3),
                          labelText: "passcodeEnr".tr().toString(),
                          labelStyle: TextStyle(fontSize: fontsize),
                          enabled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: studentInfo.password ?? "",
                          hintStyle: TextStyle(
                              fontSize: fontsize,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ),
                    //buildTextFileEdit("phone".tr().toString(), studentInfo.phone ?? "",fontsize),
                    //buildTextFileEdit("passcodeEnr".tr().toString(), studentInfo.password ?? "",fontsize),
                    //buildTextFileEdit("email".tr().toString(), userInforNew.email ?? "",fontsize),
                    buildTextFileEdit("branchNameEn".tr().toString(),
                        studentInfo.branchNameEn, fontsize),
                    buildTextFileEdit("branchNameKh".tr().toString(),
                        studentInfo.branchNameKh, fontsize),
                    buildTextFileEdit("facultyEn".tr().toString(),
                        studentInfo.facultyEn, fontsize),
                    buildTextFileEdit("facultyKh".tr().toString(),
                        studentInfo.facultyKh, fontsize),
                    buildTextFileEdit("specializationEn".tr().toString(),
                        studentInfo.specializationEn, fontsize),
                    buildTextFileEdit("specializationKh".tr().toString(),
                        studentInfo.specializationKh, fontsize),
                    buildTextFileEdit("degreeEn".tr().toString(),
                        studentInfo.degreeEn, fontsize),
                    buildTextFileEdit("degreeKh".tr().toString(),
                        studentInfo.specializationKh, fontsize),
                    buildTextFileEdit("studyTime".tr().toString(),
                        studentInfo.studyTime, fontsize),
                    buildTextFileEdit("choose_academic_price".tr().toString(),
                        "\$$choosePrice", fontsize),
                    buildTextFileEdit("studentstatus_er".tr().toString(),
                        studentInfo.stutusStudent.toString(), fontsize),
                    Text(
                      "ព័ត៌មានសម្រាប់បង់ប្រាក់",
                      style: TextStyle(
                          fontSize: fontsize,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 3),
                                labelText: "បង់ថ្លៃសិក្សាតាមរយ".tr().toString(),
                                labelStyle: TextStyle(fontSize: fontsize),
                                enabled: false,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText:
                                    studentPayinfo.paymenTGatewaYs.toString(),
                                hintStyle: TextStyle(
                                    fontSize: fontsize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 3),
                                labelText: "amount_curr".tr().toString(),
                                labelStyle: TextStyle(fontSize: fontsize),
                                enabled: false,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "\$$amountpay",
                                hintStyle: TextStyle(
                                    fontSize: fontsize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 3),
                                labelText: "paiddate".tr().toString(),
                                labelStyle: TextStyle(fontSize: fontsize),
                                enabled: false,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: paidate,
                                hintStyle: TextStyle(
                                    fontSize: fontsize * 0.8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 3),
                                labelText: "discount".tr().toString(),
                                labelStyle: TextStyle(fontSize: fontsize),
                                enabled: false,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "${studentPayinfo.discount}%",
                                hintStyle: TextStyle(
                                    fontSize: fontsize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildTextFileEdit("description".tr().toString(),
                        studentPayinfo.note.toString(), fontsize),
                    //buildTextFileEdit("amount_curr".tr().toString(), "\$"+amountpay ?? "",fontsize),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 20),
                      child: Text(
                        "invoice_screenshot".tr().toString(),
                        style:
                            TextStyle(fontSize: fontsize, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 20),
                      child: Container(
                        //padding:EdgeInsets.only(bottom: 100),
                        //width:width*0.05 ,
                        height: height * 0.34,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          //shape: BoxShape.circle,
                          image: DecorationImage(
                              //image: MemoryImage(bytes), fit: BoxFit.cover),
                              image: NetworkImage(
                                  studentPayinfo.reciept ?? urlImage),
                              fit: BoxFit.cover),
                        ),
                      ),

                      //Image.network(studentPayinfo.reciept,width: width,),
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
                          diconnected();
                        },
                        child: Text(
                          'Disconnect'.tr().toString(),
                          style: TextStyle(fontSize: fontsize),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  void diconnected() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
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
            fontSize: placeholder.length > 28 ? fontsize * 0.8 : fontsize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    ),
  );
}
