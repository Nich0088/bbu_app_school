import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/modules/enrolment/province_res.dart';

import '../../common/auth_register.dart';
import '../../register/branch_model.dart';
import '../../register/payment_res.dart';
import '../../register/place_of_birth_model.dart';
import '../../register/register_submit_res.dart';
import '../../register/register_submit_study_res.dart';
import '../../register/req/payment_req.dart';
import '../../register/req/register_submit_req.dart';
import '../../register/req/register_submit_study_req.dart';
import '../../register/req/specialization_req.dart';
import '../../register/res/payment_method_res.dart';
import '../../register/res/specialization_res.dart';
import '../../register/upload_profile_res.dart';

class RegisterService {
  bool isSuccess = false;
  String imageName = "";
  late UploadProfileRes uploadProfileRes;
  late RegisterSubmitStudyRes registerSubmitStudyRes;

  late RegisterSubmitRes registerSubmitRes;

  late PaymentRes paymentRes;

  List<PaymentMethodRes> paymentMethodList = [];
  List<PlaceOfBirthModel> placeOfBirthList = [];
  String basicAuth = AuthRegister.authKey;
  late List<BranchModel> branchList;
  late List<SpecializationModel> specializationList;

  Future<void> getBranchList() async {
    String url = AuthRegister.basicUrlRegester + AuthRegister.branBrach;
    var url1 = Uri.parse(url);
    var response = await http
        .get(url1, headers: <String, String>{'Authorization': basicAuth});
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final newsJson = map["data"];
      List<BranchModel> brandModel1 = [];
      branchList = brandModel1;
      newsJson.forEach((v) {
        branchList.add(BranchModel.fromJson(v));
      });
    }
  }

  Future<void> getSpecializationList(SpecializationReq req) async {
    String url = AuthRegister.basicUrlRegester + AuthRegister.specialization;
    SpecializationReq createReq = req;

    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      'Cookie': 'Language=en'
    };
    var url1 = Uri.parse(url);
    var response = await http.post(url1,
        headers: headers1, body: jsonEncode(createReq.toJson()));
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final newsJson = map["data"];
      List<SpecializationModel> specialization1 = [];

      newsJson.forEach((v) {
        specialization1.add(SpecializationModel.fromJson(v));
      });
      specializationList = specialization1;
    }
  }

  late SpecializationRes resSpecializationResult;

  Future<SpecializationRes> getSpecializationListNew(
      SpecializationReq req) async {
    String url = AuthRegister.basicUrlRegester + AuthRegister.specialization1;
    SpecializationReq createReq = req;
    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      'Cookie': 'Language=en'
    };
    var url1 = Uri.parse(url);
    var response = await http.post(url1,
        headers: headers1, body: jsonEncode(createReq.toJson()));
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      final jsonresponse = jsonDecode(response.body);
      final sms = SpecializationRes.fromJson(jsonresponse);
      if (sms.code == 200) {
        resSpecializationResult = sms;
      }
      return resSpecializationResult;
    } else if (response.statusCode == 401) {
      List<SpecializationModel> temtList1 = [];
      SpecializationRes usTem = SpecializationRes(
          message: "Unauthorized",
          code: 401,
          specializationModelList: temtList1);
      ////////////
      resSpecializationResult = usTem;
      return resSpecializationResult;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      throw Exception('Failed to report Faculty by itemid request..');
    }
  }

  Future<void> submitUploadImage(File file, RegisterSubmitReq req) async {
    var url = AuthRegister.basicUrlRegester + AuthRegister.uploadPhotoProfile;

    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headers = {
      "Authorization": AuthRegister.authKey,
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        file.absolute.path,
      ),
    );

    request.headers.addAll(headers);
    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          // print("Uploaded! ");
          // print('response.body ' + response.body);
          final map = json.decode(response.body);
          final newJson = map["data"];
          final model = UploadProfileRes.fromJson(newJson);
          uploadProfileRes = model;
          imageName = model.photoName;
          req.photo = model.photoName;
          postSubmitRegister(req);
        }
      });
    }).catchError((err) {
      if (kDebugMode) {
        print('error : $err');
      }
    });
  }

  Future<void> postSubmitRegister(RegisterSubmitReq req) async {
    String url = AuthRegister.basicUrlRegester + AuthRegister.newStudent1;
    RegisterSubmitReq createReq = req;
    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      //'Cookie': 'Language=en'
    };
    var url1 = Uri.parse(url);
    var response = await http.post(url1,
        headers: headers1, body: jsonEncode(createReq.toJson()));
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final newsJson = map["data"];
      if (newsJson != "") {
        registerSubmitRes = RegisterSubmitRes.fromJson(newsJson);
        if (kDebugMode) {
          print("success register");
        }
        isSuccess = true;
      } else {
        if (kDebugMode) {
          print("un success register");
        }
        isSuccess = false;
      }
    }
  }

  Future<RegisterSubmitStudyRes> postSubmitRegisterStudy(
      RegisterSubmitStudyReq req) async {
    String url =
        AuthRegister.basicUrlRegester + AuthRegister.newStudentStudyto1;
    RegisterSubmitStudyReq createReq = req;
    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      //'Cookie': 'Language=en'
    };
    var url1 = Uri.parse(url);
    var response = await http.post(url1,
        headers: headers1, body: jsonEncode(createReq.toJson()));
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final newsJson = map["data"];
      if (newsJson != "") {
        registerSubmitStudyRes = RegisterSubmitStudyRes.fromJson(newsJson);
        if (kDebugMode) {
          print("success register study");
        }
        isSuccess = true;
      } else {
        if (kDebugMode) {
          print("un success register study");
        }
        isSuccess = false;
      }
    }
    return registerSubmitStudyRes;
  }

  late ProvinceRes requestResultProvince;

  Future<ProvinceRes> getPlaceOfBirth() async {
    String url = AuthRegister.basicUrlRegester + AuthRegister.placeofBirth1;
    String username = AuthRegister.authUsernameRegister;
    String password = AuthRegister.authPpasswordRegister;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      'Cookie': 'Language=en'
    };
    var url1 = Uri.parse(url);
    var response = await http.get(url1, headers: headers1);
    if (response.statusCode == 200) {
      // final map = json.decode(response.body);
      // final newsJson = map["data"];
      // List<PlaceOfBirthModel> placeOfbirth1 = [];
      // placeOfBirthList = placeOfbirth1;
      // // PlaceOfBirthModel ress = new PlaceOfBirthModel();
      // // ress.name = "ជ្រើសរើសទីកន្លែងកំណើត";
      // // placeOfBirthList.add(ress);
      // newsJson.forEach((v) {
      //   final model = PlaceOfBirthModel.fromJson(v);
      //   placeOfBirthList.add(model);
      //   // print(model.name);
      // });
      requestResultProvince = ProvinceRes.fromJson(jsonDecode(response.body));
      return requestResultProvince;
    } else if (response.statusCode == 401) {
      throw ('Unauthorized provice . code 401');
    } else if (response.statusCode == 404) {
      throw ('Not Found provice. code 404 ');
    } else if (response.statusCode == 409) {
      throw ('Duplicate data provice. code 409');
    } else {
      throw ('Internal Server Error provice . code 500');
    }
  }

  late PaymentMethodRes resPaymentMethodResult;

  Future<PaymentMethodRes> getPaymentMethodByStudentId(String studentId) async {
    String url = AuthRegister.basicUrlRegester +
        AuthRegister.getwayPaymentMethod1 +
        studentId;
    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
    };
    var url1 = Uri.parse(url);
    var response = await http.get(url1, headers: headers1);
    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      final jsonresponse = jsonDecode(response.body);
      final sms = PaymentMethodRes.fromJson(jsonresponse);
      if (sms.code == 200) {
        resPaymentMethodResult = sms;
      }
      return resPaymentMethodResult;
    } else if (response.statusCode == 401) {
      List<DataPaymentMethodList> temtList1 = [];
      PaymentMethodRes usTem = PaymentMethodRes(
          message: "Unauthorized", code: 401, dataPaymentMethodList: temtList1);
      ////////////
      resPaymentMethodResult = usTem;
      return resPaymentMethodResult;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      throw Exception('Failed to report Faculty by itemid request..');
    }
  }

  Future<void> submitUploadImageReciept(File file, PaymentReq req) async {
    var url = AuthRegister.basicUrlRegester + AuthRegister.uploadReciept;

    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headers = {
      "Authorization": AuthRegister.authKey,
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        file.absolute.path,
      ),
    );

    request.headers.addAll(headers);
    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print("Uploaded! ");
          }
          if (kDebugMode) {
            print('response.body ${response.body}');
          }
          final map = json.decode(response.body);
          final newJson = map["data"];
          final model = UploadProfileRes.fromJson(newJson);
          uploadProfileRes = model;
          imageName = model.photoName;
          req.reciept = model.photoName;
          // postSubmitPayment(req);
        }
      });
    }).catchError((err) {
      if (kDebugMode) {
        print('error : $err');
      }
    });
  }

  Future<void> postSubmitPayment(PaymentReq req) async {
    String url = AuthRegister.basicUrlRegester + AuthRegister.paymentPost1;
    PaymentReq createReq = req;
    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
    };
    var url1 = Uri.parse(url);
    var response = await http.post(url1,
        headers: headers1, body: jsonEncode(createReq.toJson()));
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final newsJson = map["data"];
      if (newsJson != "") {
        paymentRes = PaymentRes.fromJson(newsJson);
        if (kDebugMode) {
          print("success payment");
        }
        isSuccess = true;
      } else {
        if (kDebugMode) {
          print("un success payment");
        }
        isSuccess = false;
      }
    }
  }
}
