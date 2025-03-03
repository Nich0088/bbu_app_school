import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:school_app/src/common/app_setting.dart';
import 'package:school_app/src/modules/enrolment/province_res.dart';
import 'package:school_app/src/modules/enrolment/register_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/locale_keys.g.dart';
import '../../common/auth_register.dart';
import '../../register/register_submit_res.dart';
import '../../register/req/register_submit_req.dart';
import '../../register/upload_profile_res.dart';
import 'register_step_two_screen.dart';

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, LocaleKeys.sexMale.tr()),
      Company(2, LocaleKeys.sexFemale.tr()),
    ];
  }
}

class Month {
  int id;
  String name;

  Month(this.id, this.name);

  static List<Month> getMonth() {
    return <Month>[
      Month(0, LocaleKeys.dobMonth.tr()),
      Month(1, "January"),
      Month(2, "February"),
      Month(3, "March"),
      Month(4, "April"),
      Month(5, "May"),
      Month(6, "June"),
      Month(7, "July"),
      Month(8, "August"),
      Month(9, "September"),
      Month(10, "October"),
      Month(11, "November"),
      Month(12, "December"),
    ];
  }
}

class Day {
  int id;
  String name;

  Day({required this.id, required this.name});
}

class Year {
  int id;
  String name;

  Year({required this.id, required this.name});
}

class RegistrationApplicationScreen extends StatefulWidget {
  const RegistrationApplicationScreen({super.key});

  @override
  State createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegistrationApplicationScreen> {
  final RegisterService _registerService = RegisterService();
  final ImagePicker _picker = ImagePicker();
  static final keyValidateStepOne = GlobalKey<FormState>();

  bool isLoading = false;
  bool isSubmit = false;
  UploadProfileRes uploadProfileRes = UploadProfileRes(photoName: "");
  RegisterSubmitRes registerSubmitRes = RegisterSubmitRes(
      firstName: "",
      firstNameKhmer: "",
      lastName: "",
      lastNameKhmer: "",
      sex: "",
      selectBirthMonth: 0,
      selectDay: 0,
      selectYear: 0,
      placeOfBirth: "",
      photo: "",
      phone: "");

  // List<PlaceOfBirthModel> placeList=[];
  XFile? _imageFile;
  late String pickedDate;

  // ignore: unused_field
  late String _phone = "";
  late int date;
  late int month;
  late int year;
  String imageName = "";
  final TextEditingController _textFirstNameKh = TextEditingController();
  final TextEditingController _textLastNameKh = TextEditingController();
  final TextEditingController _textFistNameEn = TextEditingController();
  final TextEditingController _textLastNameEn = TextEditingController();

  //TextEditingController _textPlaceOfBirth = TextEditingController();
  final TextEditingController _textPhone = TextEditingController();

  //List<PlaceOfBirthModel> placeOfBirthModelList = [];
  //  List<DropdownMenuItem<PlaceOfBirthModel>> _dropdownMenuItemsPlace=[];
  //  PlaceOfBirthModel _selectedPlace= PlaceOfBirthModel(name: "");

  List<ProvinceModel> placeOfBirthModelList = [];
  List<DropdownMenuItem<ProvinceModel>> _dropdownMenuItemsPlace = [];
  ProvinceModel _selectedPlace = ProvinceModel(nameObj: '');

  // void _setImageFileListFromFile(XFile? value) {
  //   _imageFile = value == null ? null : <XFile>[value][0];
  // }
  //dynamic _pickImageError;
  //String? _retrieveDataError;
  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = XFile(image!.path);
      submitUploadImageProfile();
    });
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      _phone = internationalizedPhoneNumber;
      _phone = number;
      if (kDebugMode) {
        print(number);
      }
      if (kDebugMode) {
        print(internationalizedPhoneNumber);
      }
    });
  }

  final List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems = [];
  Company _selectedCompany = Company(0, "");

  final List<Day> _dayList = [];
  List<DropdownMenuItem<Day>> _dropdownDayItems = [];
  Day _selectedDay = Day(id: 0, name: "");

  final List<Year> _yearList = [];
  List<DropdownMenuItem<Year>> _dropdownYearItems = [];
  Year _selectedYear = Year(id: 0, name: "");

  final List<Month> _monthList = Month.getMonth();
  List<DropdownMenuItem<Month>> _dropdownMonthItems = [];
  Month _selectedMonth = Month(0, "");

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    Day day = Day(id: 0, name: LocaleKeys.dobDay.tr());
    _dayList.add(day);
    for (int i = 1; i <= 31; i++) {
      Day day = Day(id: i, name: i.toString());
      _dayList.add(day);
    }

    Year year = Year(id: 0, name: LocaleKeys.dobYear.tr());
    _yearList.add(year);
    for (int i = DateTime.now().year - 70; i <= selectedDate.year; i++) {
      Year year = Year(id: i, name: i.toString());
      _yearList.add(year);
    }

    isLoading = true;
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value!;
    getPlaceOfBirth();

    super.initState();

    _dropdownMonthItems = buildDropdownMenuItemMonth(_yearList);
    _selectedMonth = _dropdownMonthItems[0].value!;

    _dropdownDayItems = buildDropdownMenuItemDay(_dayList);
    _selectedDay = _dropdownDayItems[0].value!;

    _dropdownYearItems = buildDropdownMenuItemYear(_dayList);
    _selectedYear = _dropdownYearItems[0].value!;
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = [];
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company? selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany!;
    });
  }

  onChangeDropdownItemYear(Year? year) {
    setState(() {
      _selectedYear = year!;
    });
  }

  onChangeDropdownItemDay(Day? day) {
    setState(() {
      _selectedDay = day!;
    });
  }

  onChangeDropdownItemMonth(Month? month) {
    setState(() {
      _selectedMonth = month!;
    });
  }

  List<DropdownMenuItem<ProvinceModel>> buildDropdownMenuItemPlace(List list) {
    List<DropdownMenuItem<ProvinceModel>> items = [];
    for (ProvinceModel b in placeOfBirthModelList) {
      items.add(
        DropdownMenuItem(
          value: b,
          child: Text(b.nameObj),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Day>> buildDropdownMenuItemDay(List list) {
    List<DropdownMenuItem<Day>> items = [];
    for (Day b in _dayList) {
      items.add(
        DropdownMenuItem(
          value: b,
          child: Text(b.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Month>> buildDropdownMenuItemMonth(List list) {
    List<DropdownMenuItem<Month>> items = [];
    for (Month b in _monthList) {
      items.add(
        DropdownMenuItem(
          value: b,
          child: Text(b.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Year>> buildDropdownMenuItemYear(List list) {
    List<DropdownMenuItem<Year>> items = [];
    for (Year b in _yearList) {
      items.add(
        DropdownMenuItem(
          value: b,
          child: Text(b.name),
        ),
      );
    }
    return items;
  }

  Future<void> getPlaceOfBirth() async {
    try {
      var results = await _registerService.getPlaceOfBirth();
      if (results.dataList.isNotEmpty) {
        setState(() {
          placeOfBirthModelList.addAll(results.dataList);
          _dropdownMenuItemsPlace =
              buildDropdownMenuItemPlace(placeOfBirthModelList);
          _selectedPlace = _dropdownMenuItemsPlace[0].value!;
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error from server.. $e ");
      }
    }
  }

  onChangeDropdownItemPlace(ProvinceModel? item) {
    setState(() {
      _selectedPlace = item!;
    });
  }

  void submitRegisterStepOne() async {
    final sharePre = await SharedPreferences.getInstance();
    if (imageName.isEmpty) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: TextButton(
              child: const Text("Please choose image"),
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
        RegisterSubmitReq req = RegisterSubmitReq(
          firstName: _textFistNameEn.text,
          lastName: _textLastNameEn.text,
          firstNameKhmer: _textFirstNameKh.text,
          lastNameKhmer: _textLastNameKh.text,
          selectYear: _selectedYear.id,
          selectDay: _selectedDay.id,
          selectBirthMonth: _selectedMonth.id,
          photo: imageName,
          phone: _textPhone.text,
          studentTemId: "",
          placeOfBirth: _selectedPlace.nameObj,
          sex: _selectedCompany.id == 1 ? "Male" : "Female",
        );
        await _registerService.postSubmitRegister(req);
        RegisterSubmitRes resG = _registerService.registerSubmitRes;
        if (resG.studentTemId != null) {
          await sharePre.setString("studentTem_id", resG.studentTemId!);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterInfo(
                registerSubmitRes: resG,
              ),
            ),
          );
        } else {
          isSubmit = false;
          // ignore: use_build_context_synchronously
          showAlertDialogConfirmSignUp(context, LocaleKeys.tryAgain.tr());
        }
        isSubmit = false;
      });
    }
  }

  DateTime selectedDate = DateTime.now();

  /// This builds recuperation date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                // if (picked != null && picked != selectedDate)
                //   setState(() {
                //     selectedDate = picked;
                //   });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontSize = height * 0.02;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.066,
        elevation: 0,
        title: Text(
          LocaleKeys.registrationApplication.tr(),
          style: TextStyle(fontSize: fontSize),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: fontSize,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Form(
                key: keyValidateStepOne,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 5),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: height * 0.2,
                              height: height * 0.24,
                              // decoration: BoxDecoration(
                              //   border:
                              //       Border.all(width: 4, color: Colors.black26),
                              //   // shape: BoxShape.circle,
                              // ),
                              child: _imageFile == null
                                  ? ClipRRect(
                                      // borderRadius: BorderRadius.circular(1000),
                                      child: Image.asset(
                                          'assets/registration_application/user.png',
                                          fit: BoxFit.fill),
                                    )
                                  : ClipRRect(
                                      // borderRadius: BorderRadius.circular(1000),
                                      child: Image.file(
                                      File(_imageFile!.path),
                                      fit: BoxFit.cover,
                                    )),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: getImageFromGallery,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField(
                              LocaleKeys.firstNameKh.tr(),
                              _textFirstNameKh,
                              "${LocaleKeys.firstNameKh.tr()} ${LocaleKeys.canNotBeEmpty.tr()}"),
                          //_validateFirstnameKh
                          const SizedBox(height: 15),
                          buildTextField(
                              LocaleKeys.lastNameKh.tr(),
                              _textLastNameKh,
                              "${LocaleKeys.lastNameKh.tr()} ${LocaleKeys.canNotBeEmpty.tr()}"),
                          const SizedBox(height: 15),
                          buildTextField(
                              LocaleKeys.fistNameEn.tr(),
                              _textFistNameEn,
                              "${LocaleKeys.fistNameEn.tr()} ${LocaleKeys.canNotBeEmpty.tr()}"),
                          const SizedBox(height: 15),
                          buildTextField(
                              LocaleKeys.lastNameEn.tr(),
                              _textLastNameEn,
                              "${LocaleKeys.lastNameEn.tr()} ${LocaleKeys.canNotBeEmpty.tr()}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              LocaleKeys.sex.tr(),
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          _buildSex(),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(LocaleKeys.dob.tr(),
                                style: TextStyle(fontSize: fontSize)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    //color: Colors.grey[300],
                                    //borderRadius: BorderRadius.circular(5)),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        style: TextStyle(
                                            fontSize: fontSize,
                                            color: Colors.black),
                                        isExpanded: true,
                                        // isDense: true,
                                        // iconSize: 35,
                                        iconEnabledColor: Colors.blue,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey,
                                          size: fontSize,
                                        ),
                                        value: _selectedDay,
                                        items: _dropdownDayItems,
                                        onChanged: onChangeDropdownItemDay,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    //color: Colors.grey[300],borderRadius: BorderRadius.circular(5)
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        style: TextStyle(
                                            fontSize: fontSize,
                                            color: Colors.black),
                                        isExpanded: true,
                                        // isDense: true,
                                        // iconSize: 35,
                                        iconEnabledColor: Colors.blue,
                                        icon: const Icon(Icons.arrow_drop_down,
                                            color: Colors.grey),
                                        value: _selectedMonth,
                                        items: _dropdownMonthItems,
                                        onChanged: onChangeDropdownItemMonth,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    //color: Colors.grey[300],
                                    //borderRadius: BorderRadius.circular(5)
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        style: TextStyle(
                                            fontSize: fontSize,
                                            color: Colors.black),
                                        // isExpanded: true,
                                        // isDense: true,
                                        // iconSize: 35,
                                        iconEnabledColor: Colors.blue,
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: Colors.grey, size: fontSize),
                                        value: _selectedYear,
                                        items: _dropdownYearItems,
                                        onChanged: onChangeDropdownItemYear,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // _buildSex(),
                              // _buildSex(),
                            ],
                          ),

                          const SizedBox(height: 20),
                          // _phoneField(""),
                          buildTextField(LocaleKeys.phone.tr(), _textPhone,
                              "${LocaleKeys.phone.tr()} ${LocaleKeys.canNotBeEmpty.tr()}"),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(LocaleKeys.dop.tr(),
                                style: TextStyle(fontSize: fontSize)),
                          ),
                          // buildTextField("ទីកន្លែងកំណើត(ខេត្ត/ក្រុង)", _textPlaceOfBirth),
                          _buildDateOfBirth(),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                if (keyValidateStepOne.currentState!
                                    .validate()) {
                                  if (_imageFile!.path !=
                                      "assets/profile_none.png") {
                                    setState(() {
                                      isSubmit = true;
                                    });
                                    submitRegisterStepOne();
                                  } else {
                                    isLoading = false;
                                  }
                                }
                                /* RegisterSubmitRes resG = RegisterSubmitRes();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterInfo(
                                          registerSubmitRes: resG,
                                        ),
                                      ),
                                    ); */
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.indigo[900],
                                textStyle: TextStyle(fontSize: fontSize),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.indigo[900],
                              ),
                              child: Text(
                                LocaleKeys.nextGo.tr(),
                                style: TextStyle(
                                    fontSize: fontSize, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      String validateString) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontSize = height * 0.02;
    return TextFormField(
      controller: controller,
      //validator: validate,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateString;
        }
        return null;
      },
      style: TextStyle(
        fontSize: fontSize,
        color: AppColor.textTertiaryColor,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: height * 0.02),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: height * 0.026,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
    );
  }

  Widget _buildSex() {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontSize = height * 0.02;
    return Container(
      height: height * 0.05,
      decoration: BoxDecoration(
        //color: Colors.grey[300], borderRadius: BorderRadius.circular(5)
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            style: TextStyle(fontSize: fontSize, color: Colors.black),
            isExpanded: true,
            // isDense: true,
            iconSize: height * 0.03,
            iconEnabledColor: Colors.blue,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            value: _selectedCompany,
            items: _dropdownMenuItems,
            onChanged: onChangeDropdownItem,
          ),
        ),
      ),
    );
  }

  Widget _buildDateOfBirth() {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.05,
      decoration: BoxDecoration(
        //color: Colors.grey[300], borderRadius: BorderRadius.circular(5)
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            // isDense: true,
            style: TextStyle(fontSize: height * 0.026, color: Colors.black),
            iconSize: height * 0.03,
            iconEnabledColor: Colors.blue,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            value: _selectedPlace,
            items: _dropdownMenuItemsPlace,
            onChanged: onChangeDropdownItemPlace,
          ),
        ),
      ),
    );
  }

  /*  Widget _phoneField(String title) {
    return InternationalPhoneInput(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        decoration: InputDecoration(
            isDense: true,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.blue[900], width: 2)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            hintText: "លេខទូរស័ព្ទ",
            fillColor: Colors.grey[50],
            filled: true),
        onPhoneNumberChange: onPhoneNumberChange,
        initialPhoneNumber: _phone,
        initialSelection: "KH",
        enabledCountries: ['+855'],
        showCountryCodes: true);
  }
 */
  showAlertDialogConfirmSignUp(BuildContext context, String message) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("បោះបង់"),
      onPressed: () {
        Navigator.of(context).pop();
        isSubmit = false;
      },
    );
    Widget continueButton = TextButton(
      child: const Text("ព្រម"),
      onPressed: () {
        submitRegisterStepOne();
        Navigator.of(context).pop();
        setState(() {
          isSubmit = false;
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("សារ..."),
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

  void submitUploadImageProfile() async {
    setState(() {
      isSubmit = true;
    });
    try {
      String username = AuthRegister.authUsername1;
      String password = AuthRegister.authPpassword1;
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      var headers1 = {
        //'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': basicAuth,
        "Content-type": "multipart/form-data"
        //'Cookie': 'Language=en'
      };
      var url =
          AuthRegister.basicUrlRegester + AuthRegister.uploadPhotoProfile1;

      ///MultiPart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      /* Map<String, String> headers = {
        "Authorization": AuthRegister.AUTH_KEY,
        "Content-type": "multipart/form-data"
      }; */
      Map<String, String> headers = headers1;
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          _imageFile!.path,
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
              isSubmit = false;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      child: TextButton(
                    child: const Text("Image size is big"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      getImageFromGallery();
                    },
                  ));
                });
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
        isSubmit = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: TextButton(
              child: const Text("Image size is big"),
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
    setState(() {
      isSubmit = false;
    });
    if (kDebugMode) {
      print("Image === $imageName");
    }
  }
}
