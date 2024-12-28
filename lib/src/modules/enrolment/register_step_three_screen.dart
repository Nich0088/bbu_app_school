import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:school_app/src/modules/enrolment/register_service.dart';

import '/generated/locale_keys.g.dart';
import '../../common/auth_register.dart';
import '../../register/payment_res.dart';
import '../../register/register_submit_res.dart';
import '../../register/register_submit_study_res.dart';
import '../../register/req/payment_req.dart';
import '../../register/res/payment_method_res.dart';
import '../../register/upload_profile_res.dart';

class PaymentGetWay extends StatefulWidget {
  final RegisterSubmitRes registerSubmitRes;
  final RegisterSubmitStudyRes registerSubmitStudyRes;

  const PaymentGetWay({
    super.key,
    required this.registerSubmitRes,
    required this.registerSubmitStudyRes,
  });

  @override
  State createState() => _PaymentGetWayState();
}

class _PaymentGetWayState extends State<PaymentGetWay> {
  late RegisterSubmitRes registerSubmitRes;
  late RegisterSubmitStudyRes registerSubmitStudyRes;
  final TextEditingController _noteEdit = TextEditingController();
  bool isLoading = false;
  bool isPayment = false;
  double price = 0, afterDiscountGlobal = 0.0, discountGlobal = 0;
  List<DataPaymentMethodList> paymentMethodList = [];
  List<BankList> bankList = [];

  String studentId = "3a2c2dmyuooyzoiqkzv3qe4p";
  File? _image;
  String imageName = "", noteDiscountPayment = "";
  List<DropdownMenuItem<BankList>> _dropdownMenuItemsPayment = [];
  BankList? _selectedBank;

  final ImagePicker _picker = ImagePicker();

  //////////
  ///
  List<DiscountMaster> discountMasterList = DiscountMaster.getDiscount();
  List<DropdownMenuItem<DiscountMaster>> dropdowndiscountMasterItems = [];
  DiscountMaster? selectedDiscountMaster;

  List<DiscountDoctor> discountDoctorList = DiscountDoctor.getDiscount();
  List<DropdownMenuItem<DiscountDoctor>> dropdownDiscountDoctorItems = [];
  DiscountDoctor? selectedDiscountDoctor;

  ///
  /////////////

  List<DropdownMenuItem<BankList>> buildDropdownMenuItemPayment(List payments) {
    List<DropdownMenuItem<BankList>> items = [];
    for (BankList b in payments) {
      items.add(
        DropdownMenuItem(
          value: b,
          child: Text(b.bankName),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItemCampus(BankList? selectedItem) {
    setState(() {
      _selectedBank = selectedItem!;
    });
  }

  @override
  void initState() {
    registerSubmitRes = widget.registerSubmitRes;
    registerSubmitStudyRes = widget.registerSubmitStudyRes;
    studentId = registerSubmitRes.studentTemId!;
    price = registerSubmitStudyRes.chooseAcademicPrice;

    getBankList(studentId);

    isLoading = true;
    super.initState();

    dropdowndiscountMasterItems =
        buildDropdownMenuItemDiscountMaster(discountMasterList);
    selectedDiscountMaster = dropdowndiscountMasterItems[0].value!;

    dropdownDiscountDoctorItems =
        buildDropdownMenuItemDiscountDoctor(discountDoctorList);
    selectedDiscountDoctor = dropdownDiscountDoctorItems[0].value!;
  }

  void getBankList(String id) async {
    RegisterService registerService = RegisterService();
    final result = await registerService.getPaymentMethodByStudentId(id);
    setState(() {
      bankList = result.dataPaymentMethodList[0].bankList;
      paymentMethodList = result.dataPaymentMethodList;
      afterDiscountGlobal = paymentMethodList[0].afterDiscount;
      discountGlobal = paymentMethodList[0].discount;
      _dropdownMenuItemsPayment = buildDropdownMenuItemPayment(bankList);
      _selectedBank = _dropdownMenuItemsPayment[0].value!;
      isLoading = false;
    });
  }

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);

      submitUploadImageReciept();
    });
  }

  void submitPayment() async {
    RegisterService registerService = RegisterService();
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.027;
    // ignore: unnecessary_null_comparison
    if (imageName == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: TextButton(
              child: Text(
                "Please choose image",
                style: TextStyle(fontSize: fontsize),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                getImageFromGallery();
              },
            ),
          );
        },
      );
    } else {
      Future.delayed(const Duration(seconds: 2), () async {
        PaymentReq req = PaymentReq(
            bankId: _selectedBank!.bankId,
            amount: afterDiscountGlobal,
            discount: discountGlobal,
            note: "${_noteEdit.text} $noteDiscountPayment",
            accNumber: _selectedBank!.accNumber,
            accName: _selectedBank!.accName,
            reciept: imageName,
            imageQrcode: imageName,
            studentId: studentId);

        await registerService.postSubmitPayment(req);
        PaymentRes res = registerService.paymentRes;
        // ignore: unnecessary_null_comparison
        if (res.studentId != null) {
          // ignore: use_build_context_synchronously
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const HomeScreen(
          //       isRegister: true,logout: false,
          //     ),
          //   ),
          // );
        } else {
          // ignore: use_build_context_synchronously
          showAlertDialogConfirmSignUp(context, "ព្យាយាមម្តងទៀត");
        }
        isPayment = false;
      });
    }
  }

  List<DropdownMenuItem<DiscountMaster>> buildDropdownMenuItemDiscountMaster(
      List list) {
    List<DropdownMenuItem<DiscountMaster>> items = [];
    for (DiscountMaster b in discountMasterList) {
      items.add(
        DropdownMenuItem(
          value: b,
          child: Text(b.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<DiscountDoctor>> buildDropdownMenuItemDiscountDoctor(
      List list) {
    List<DropdownMenuItem<DiscountDoctor>> items = [];
    for (DiscountDoctor b in discountDoctorList) {
      items.add(
        DropdownMenuItem(
          value: b,
          child: Text(b.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItemDiscountMaster(DiscountMaster? item) {
    setState(() {
      selectedDiscountMaster = item!;
      var priceFull = registerSubmitStudyRes.chooseAcademicPrice;
      double price2y3y = 0, price1 = 0;
      //2year
      if (priceFull >= 1800) {
        price1 = priceFull / 2;
        price2y3y = priceFull - price1;
      } else {
        price1 = priceFull;
      }
      var result1 = price1 - ((price1 * item.value) / 100) + price2y3y;
      afterDiscountGlobal = result1;
      discountGlobal = item.value;
      noteDiscountPayment = item.name;
    });
  }

  onChangeDropdownItemDiscountDoctor(DiscountDoctor? item) {
    setState(() {
      selectedDiscountDoctor = item!;
      var priceFull = registerSubmitStudyRes.chooseAcademicPrice;
      double price2y3y = 0, price1 = 0;
      //3year
      if (priceFull >= 6480) {
        price1 = priceFull / 3;
        price2y3y = priceFull - price1;
      } else {
        price1 = priceFull;
      }
      var result1 = price1 - ((price1 * item.value) / 100) + price2y3y;
      afterDiscountGlobal = result1;
      discountGlobal = item.value;
      noteDiscountPayment = item.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.02;
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
          LocaleKeys.registerStepThree.tr(),
          style: TextStyle(fontSize: fontsize),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    ////master==3 || ////doctor======4
                    registerSubmitStudyRes.degreeId == 3 ||
                            registerSubmitStudyRes.degreeId == 4
                        ?
                        //
                        Container(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "ប្រភេទចុះឈ្មោះនិស្សិត",
                                    style: TextStyle(fontSize: fontsize),
                                  ),
                                ),
                                Text(
                                  "ផ្ដល់ជូនអាហារូបករណ៍សិក្សា $discountGlobal% ក្នុងឆ្នាំទី១",
                                  style: TextStyle(
                                      fontSize: height * 0.015,
                                      color: Colors.yellow[900]),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(
                            height: 1,
                          ),
                    registerSubmitStudyRes.degreeId == 3
                        ? widgetSelectDiscountMaster()
                        : const SizedBox(
                            height: 1,
                          ),
                    registerSubmitStudyRes.degreeId == 4
                        ? widgetSelectDiscountDoctor()
                        : const SizedBox(
                            height: 1,
                          ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        LocaleKeys.payTuitionFeesVia.tr(),
                        style: TextStyle(fontSize: fontsize),
                      ),
                    ),
                    buildSelectPayment(),
                    buildTextField(
                        "Account Number", _selectedBank!.accName, false),
                    buildTextField(
                        "Account Name", _selectedBank!.accNumber, false),
                    const SizedBox(height: 10),
                    Text("QR CODE", style: TextStyle(fontSize: fontsize)),
                    const SizedBox(height: 5),
                    // Image box

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: size.height / 2,
                            width: size.width / 1.2,
                            color: Colors.grey,
                            child: Image.network(
                              _selectedBank!.qrcodeImge,
                              fit: BoxFit.cover,
                            )),
                      ],
                    ),
                    // FlatButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width / 1.2,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.indigo[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: Colors.indigo[900],
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => QRCodeScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.qr_code_scanner_rounded,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Scan QR Code",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.02),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height / 2,
                          width: size.width / 1.2,
                          color: Colors.grey,
                          child: Center(
                            // ignore: unnecessary_null_comparison
                            child: _image == null
                                ? Text(
                                    "No Image Selected.",
                                    style: TextStyle(fontSize: height * 0.02),
                                  )
                                : Image.file(_image!),
                          ),
                        )
                      ],
                    ),
                    // FlatButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width / 1.2,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.indigo[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Colors.indigo[900],
                            ),
                            onPressed: getImageFromGallery,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.image_search,
                                    color: Colors.white),
                                Text(
                                  "Browse",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.02),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildTextField(
                        "Amount",
                        // "Discount : " +
                        //     paymentMethodList[0].discount.toString() +
                        //     "% = " +
                        "\$$afterDiscountGlobal",
                        true),
                    buildTextField2("Note", "", _noteEdit),

                    Text(
                      "Full Price \$${registerSubmitStudyRes.chooseAcademicPrice}",
                      style: TextStyle(fontSize: height * 0.02),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.indigo[900],
                          textStyle: TextStyle(fontSize: fontsize),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.indigo[900],
                        ),
                        onPressed: () {
                          setState(() {
                            isPayment = true;
                          });
                          submitPayment();
                          // submitUploadImageReciept();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterInfo()));
                        },
                        child: Text(
                          LocaleKeys.toPay.tr(),
                          style: TextStyle(
                              fontSize: fontsize, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildSelectPayment() {
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            style: TextStyle(fontSize: height * 0.02, color: Colors.black),
            isExpanded: true,
            // isDense: true,
            iconSize: height * 0.04,
            iconEnabledColor: Colors.blue,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: height * 0.02,
            ),
            value: _selectedBank,
            items: _dropdownMenuItemsPayment,
            onChanged: onChangeDropdownItemCampus,
          ),
        ),
      ),
    );
  }

  Widget widgetSelectDiscountMaster() {
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            style: TextStyle(fontSize: height * 0.02, color: Colors.black),
            isExpanded: true,
            // isDense: true,
            iconSize: height * 0.04,
            iconEnabledColor: Colors.blue,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: height * 0.02,
            ),
            value: selectedDiscountMaster,
            items: dropdowndiscountMasterItems,
            onChanged: onChangeDropdownItemDiscountMaster,
          ),
        ),
      ),
    );
  }

  Widget widgetSelectDiscountDoctor() {
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            style: TextStyle(fontSize: height * 0.02, color: Colors.black),
            isExpanded: true,
            // isDense: true,
            iconSize: height * 0.04,
            iconEnabledColor: Colors.blue,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: height * 0.02,
            ),
            value: selectedDiscountDoctor,
            items: dropdownDiscountDoctorItems,
            onChanged: onChangeDropdownItemDiscountDoctor,
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool enable) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.02;
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 20),
      child: TextField(
        style: TextStyle(fontSize: fontsize),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: height * 0.02),
          enabled: enable,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
              fontSize: fontsize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget buildTextField2(
      String labelText, String placeholder, TextEditingController controller) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.02;
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 20),
      child: TextField(
        style: TextStyle(fontSize: fontsize),
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: fontsize),
          // enabled: false,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
              fontSize: fontsize,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        maxLength: 100,
        maxLines: 3,
      ),
    );
  }

  showAlertDialogConfirmSignUp(BuildContext context, String message) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.02;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "បោះបង់",
        style: TextStyle(fontSize: fontsize),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          isPayment = false;
        });
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "ព្រម",
        style: TextStyle(fontSize: fontsize),
      ),
      onPressed: () {
        submitPayment();
        Navigator.of(context).pop();
        setState(() {
          isPayment = false;
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "សារ...",
        style: TextStyle(fontSize: fontsize),
      ),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void submitUploadImageReciept() async {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.02;
    setState(() {
      isPayment = true;
    });
    try {
      var url = AuthRegister.basicUrlRegester + AuthRegister.uploadReciept1;
      String username = AuthRegister.authUsername1;
      String password = AuthRegister.authPpassword1;
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      var headers1 = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': basicAuth,
      };

      ///MultiPart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      Map<String, String> headers = headers1;
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          _image!.absolute.path,
        ),
      );
      request.headers.addAll(headers);
      // var res = await request.send();
      await request.send().then((result) {
        http.Response.fromStream(result).then((response) {
          if (response.statusCode == 200) {
            // print("Uploaded! ");
            // print('response.body ' + response.body);
            final map = json.decode(response.body);
            final newJson = map["data"];
            final model = UploadProfileRes.fromJson(newJson);
            imageName = model.photoName;
          } else {
            imageName = "";
            setState(() {
              isPayment = false;
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: TextButton(
                    child: Text(
                      "Image size is big",
                      style: TextStyle(fontSize: fontsize),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      getImageFromGallery();
                    },
                  ),
                );
              },
            );
          }
        });
      }).catchError((err) {
        if (kDebugMode) {
          print('error : $err');
        }
      });
    } on SocketException {
      imageName = "";
      setState(() {
        isPayment = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: TextButton(
              child: Text(
                "Image size is big",
                style: TextStyle(fontSize: fontsize),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                getImageFromGallery();
              },
            ),
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error during converting to Base64");
      }
      //there is error during converting file image to base64 encoding.
    }
    if (kDebugMode) {
      print("=======image=== $imageName");
    }
    setState(() {
      isPayment = false;
    });
  }
}

class DiscountMaster {
  double value;
  String name;

  DiscountMaster({required this.value, required this.name});

  static List<DiscountMaster> getDiscount() {
    return <DiscountMaster>[
      DiscountMaster(value: 10.0, name: 'MOU (10%)'),
      DiscountMaster(value: 25.0, name: 'អតីតនិស្សិត BBU (25%)'),
      DiscountMaster(value: 20.0, name: ' និស្សិតថ្មី (20%)'),
      DiscountMaster(
          value: 10.0, name: ' បងប្អូនបង្កើត, ពីរមហាវិទ្យាល័យ (10%)'),
    ];
  }
}

class DiscountDoctor {
  double value;
  String name;

  DiscountDoctor({required this.value, required this.name});

  static List<DiscountDoctor> getDiscount() {
    return <DiscountDoctor>[
      DiscountDoctor(value: 10.0, name: 'MOU (10%)'),
      DiscountDoctor(value: 10.0, name: 'អតីតនិស្សិត BBU (10%)'),
      DiscountDoctor(value: 5.0, name: ' និស្សិតថ្មី (5%)'),
      DiscountDoctor(
          value: 10.0, name: ' បងប្អូនបង្កើត, ពីរមហាវិទ្យាល័យ (10%)'),
    ];
  }
}
