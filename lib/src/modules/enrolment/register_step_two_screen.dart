import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/src/modules/enrolment/register_service.dart';
import 'package:school_app/src/modules/enrolment/register_service_new_data.dart';

import '/generated/locale_keys.g.dart';
import '../../register/register_submit_res.dart';
import '../../register/register_submit_study_res.dart';
import '../../register/req/register_submit_study_req.dart';
import '../../register/req/specialization_req.dart';
import '../../register/res/specialization_res.dart';
import 'branch/res/branch_res.dart';
import 'branch/res/degree_res.dart';
import 'branch/res/faculty_res.dart';
import 'register_step_three_screen.dart';

class RegisterInfo extends StatefulWidget {
  final RegisterSubmitRes registerSubmitRes;

  const RegisterInfo({required this.registerSubmitRes, super.key});

  @override
  State createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  RegisterService registerService = RegisterService();
  RegisterServiceNewData regisServiceNew = RegisterServiceNewData();
  late RegisterSubmitRes registerSubmitRes;
  bool loading = false;
  bool isSummit = false;
  List<DataBranchList> branchDataList = [];
  List<DataDegreeList> degreeDataList = [];
  List<DataFacultyList> facultyDataList = [];

  //List<DataListLocatPre> communeRecieveDataList = [];
  List<SpecializationModel> _specializationList = [];
  List<TimeStudyModel> _timeStudyList = [];
  List<PriceChooseModel> _choosePriceList = [];

//////add 23-5-2022=====

  List<DropdownMenuItem<DataBranchList>> _dropdownMenuItemsBranch = [];
  DataBranchList? _selectedBranch =
      DataBranchList(id: 0, name: "", nameKh: "", degreses: "");
  String seletedBranch = "";

  List<DropdownMenuItem<DataBranchList>> buildDropdownMenuItemBranch(
      List list) {
    List<DropdownMenuItem<DataBranchList>> items = [];
    items.add(
      DropdownMenuItem(
        value: null,
        child: Text("${LocaleKeys.chooses.tr()} ${LocaleKeys.campus.tr()}"),
      ),
    );
    for (DataBranchList ix in branchDataList) {
      items.add(
        DropdownMenuItem(
          value: ix,
          child: Text(ix.nameKh),
        ),
      );
    }
    return items;
  }

////////degree====
  List<DropdownMenuItem<DataDegreeList>> _dropdownMenuItemsDegree = [];
  DataDegreeList? _selectedDegree;
  String seletedDegree = "";

  List<DropdownMenuItem<DataDegreeList>> buildDropdownMenuItemDegree(
      List list) {
    List<DropdownMenuItem<DataDegreeList>> items = [];
    items.add(
      DropdownMenuItem(
        value: null,
        child: Text("${LocaleKeys.chooses.tr()} ${LocaleKeys.degree.tr()}"),
      ),
    );
    for (DataDegreeList ix in degreeDataList) {
      items.add(
        DropdownMenuItem(
          value: ix,
          child: Text(ix.nameKh),
        ),
      );
    }
    return items;
  }

  ////////faculty====
  List<DropdownMenuItem<DataFacultyList>> _dropdownMenuItemsFaculty = [];
  DataFacultyList? _selectedFaculty;
  String seletedFaculty = "";

  List<DropdownMenuItem<DataFacultyList>> buildDropdownMenuItemFaculty(
      List list) {
    List<DropdownMenuItem<DataFacultyList>> items = [];
    if (facultyDataList.isEmpty) {
      items.add(
        DropdownMenuItem(
          value: null,
          child: Text("${LocaleKeys.chooses.tr()} ${LocaleKeys.faculty.tr()}"),
        ),
      );
    }

    for (DataFacultyList ix in facultyDataList) {
      items.add(
        DropdownMenuItem(
          value: ix,
          child: Text(ix.nameKh),
        ),
      );
    }
    return items;
  }

/* List<DropdownMenuItem<Specialization>> buildDropdownMenuItemSpe(List spes) {
    List<DropdownMenuItem<Specialization>> items = [];
    for (Specialization spe in spes) {
      items.add(
        DropdownMenuItem(
          value: spe,
          child: Text(spe.nameKh),
        ),
      );
    }
    return items;
  } */
  /*  List<DropdownMenuItem<BranchModel>> _dropdownMenuItemsCampus;
  List<DropdownMenuItem<DataDegreeList>> _dropdownMenuItemsDegree;
  List<DropdownMenuItem<Faculties>> _dropdownMenuItemsFaculty;
  */
  //List<DropdownMenuItem<Specialization>> _dropdownMenuItemsSpecialization;
  List<DropdownMenuItem<TimeStudyModel>> _dropdownMenuItemsTime = [];
  List<DropdownMenuItem<PriceChooseModel>> _dropdownMenuItemsPrice = [];

  /*
  BranchModel _selectedCampus;
  DataDegreeList _selectDegree;
  Faculties _selectFaculty;
  int _indexBranch = 0;
  int _indexDegree = 0;
   */
  //Specialization _selectSpecialization;
  TimeStudyModel _selectTime = TimeStudyModel(id: 0, studyTime: "");
  PriceChooseModel _selectPrice =
      PriceChooseModel(price: 0, namePrice: "", namePriceKh: "");

  @override
  void initState() {
    loading = true;
    super.initState();
    getBranchList();
    registerSubmitRes = widget.registerSubmitRes;
  }

//DegreeData
  void getBranchList() async {
    final result = await regisServiceNew.getBranch();

    setState(() {
      branchDataList = result.dataBranchList;
      _dropdownMenuItemsBranch = buildDropdownMenuItemBranch(branchDataList);
      if (_dropdownMenuItemsBranch.isNotEmpty) {
        _selectedBranch = _dropdownMenuItemsBranch[0].value;
      }
    });
    getDegree();
    loading = false;
  }

  void getDegree() async {
    final resultDegree = await regisServiceNew.getDegree();
    setState(() {
      //degreeDataList=[];
      degreeDataList = resultDegree.dataListDegree;

      _dropdownMenuItemsDegree = buildDropdownMenuItemDegree(degreeDataList);
      _selectedDegree = _dropdownMenuItemsDegree[0].value;
    });
    int degreeid1 = 0;
    // ignore: unnecessary_null_comparison
    if (_selectedDegree != null) {
      degreeid1 = _selectedDegree!.id;
    }

    //if(_selectedDegree!=null){
    getFaculty(degreeid1);
    //}
  }

  void getFaculty(int degeeid) async {
    final resultFaculty = await regisServiceNew.getFaculty(degeeid);

    // ignore: unnecessary_null_comparison
    if (resultFaculty != null) {
      setState(() {
        //facultyDataList=[];
        facultyDataList = resultFaculty.dataFacultyList;
        _dropdownMenuItemsFaculty =
            buildDropdownMenuItemFaculty(facultyDataList);
        _selectedFaculty = _dropdownMenuItemsFaculty[0].value;
      });
      SpecializationReq req =
          SpecializationReq(facultyId: _selectedFaculty!.id, degeeId: degeeid);

      getSpecializationList(req);
    }
  }

  void getSpecializationList(SpecializationReq req) async {
    //await registerService.getSpecializationList(req);
    final result = await registerService.getSpecializationListNew(req);

    var listSkill = result.specializationModelList;
    setState(() {
      //_specializationList=[];
      _specializationList = listSkill;
      _dropdownMenuItemsSpecialization =
          buildDropdownMenuItemSpecialization(listSkill);
      _selectedSpecialization = _dropdownMenuItemsSpecialization[0].value!;
      ////////////
      ///
      ///
      _timeStudyList = listSkill[0].timeStudiesList;
      _dropdownMenuItemsTime = buildDropdownMenuItemTime(_timeStudyList);
      _selectTime = _dropdownMenuItemsTime[0].value!;
      _choosePriceList = listSkill[0].priceChooseList;
      _dropdownMenuItemsPrice = buildDropdownMenuItemPrice(_choosePriceList);
      _selectPrice = _dropdownMenuItemsPrice[0].value!;

      ///
      ////////
    });
  }

  ////////Specialization====
  List<DropdownMenuItem<SpecializationModel>> _dropdownMenuItemsSpecialization =
      [];
  SpecializationModel? _selectedSpecialization;
  late String seletedSpecialization;

  List<DropdownMenuItem<SpecializationModel>>
      buildDropdownMenuItemSpecialization(List list) {
    List<DropdownMenuItem<SpecializationModel>> items = [];
    /* items.add(
      DropdownMenuItem(
        value: null,
        child: Text("ជ្រើសរើសមហាវិទ្យាល័យ"),
      ),
    ); */
    for (SpecializationModel ix in _specializationList) {
      items.add(
        DropdownMenuItem(
          value: ix,
          child: Text(ix.nameKh),
        ),
      );
    }
    return items;
  }

  /* List<DropdownMenuItem<BranchModel>> buildDropdownMenuItemCampus(
      List campuses) {
    List<DropdownMenuItem<BranchModel>> items = [];
    for (BranchModel b in _branchList) {
      items.add(
        DropdownMenuItem(
          value: b,
          child: Text(b.nameKh),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<DataDegreeList>> buildDropdownMenuItemDegree(List degrees) {
    List<DropdownMenuItem<DataDegreeList>> items =[];
    for (DataDegreeList degree in degrees) {
      items.add(
        DropdownMenuItem(
          value: degree,
          child: Text(degree.nameKh),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Faculties>> buildDropdownMenuItemFaculty(
      List faculties) {
    List<DropdownMenuItem<Faculties>> items = [];
    for (Faculties faculty in faculties) {
      items.add(
        DropdownMenuItem(
          value: faculty,
          child: Text(faculty.nameKh),
        ),
      );
    }
    return items;
  } */

  /*  List<DropdownMenuItem<Specialization>> buildDropdownMenuItemSpe(List spes) {
    List<DropdownMenuItem<Specialization>> items = [];
    for (Specialization spe in spes) {
      items.add(
        DropdownMenuItem(
          value: spe,
          child: Text(spe.nameKh),
        ),
      );
    }
    return items;
  } */

  //
  List<DropdownMenuItem<TimeStudyModel>> buildDropdownMenuItemTime(List times) {
    List<DropdownMenuItem<TimeStudyModel>> items = [];
    for (TimeStudyModel time in times) {
      items.add(
        DropdownMenuItem(
          value: time,
          child: Text(time.studyTime),
        ),
      );
    }
    return items;
  }

  //
  List<DropdownMenuItem<PriceChooseModel>> buildDropdownMenuItemPrice(
      List prices) {
    List<DropdownMenuItem<PriceChooseModel>> items = [];
    for (PriceChooseModel price in prices) {
      items.add(
        DropdownMenuItem(
          value: price,
          child: Text("${price.price}\$ /${price.namePriceKh}"),
        ),
      );
    }
    return items;
  }

  /* onChangeDropdownItemCampus(BranchModel selectedCampus) {
    setState(() {
      _selectedCampus = selectedCampus;
      print(_selectedCampus.id - 1);
      var listDdd=this._branchList[_selectedCampus.id - 1].degreses;
      listDdd.forEach((element) {
        DataDegreeList list1=new DataDegreeList();
        list1.faculties=element.faculties;
        list1.id=element.id;
        list1.name=element.name;
        list1.nameKh=element.nameKh;
        _degreeList.add(list1);
      });

      // _dropdownMenuItemsDegree = buildDropdownMenuItemDegree(_degreeList);
      // _selectDegree = _dropdownMenuItemsDegree[0].value;
    });
  }

  onChangeDropdownItemDegree(DataDegreeList seletedDegree) {
    setState(() {
      _selectDegree = seletedDegree;
      _facultyList =
          this._branchList[0].degreses[_selectDegree.id - 1].faculties;
      _dropdownMenuItemsFaculty = buildDropdownMenuItemFaculty(_facultyList);
      _selectFaculty = _dropdownMenuItemsFaculty[0].value;
    });
  }
 */
  onChangeDropdownItemFaculty(DataFacultyList? selectedFaculty) {
    setState(() {
      _selectedFaculty = selectedFaculty!;
      SpecializationReq req = SpecializationReq(
          facultyId: selectedFaculty.id, degeeId: selectedFaculty.degreeId);

      getSpecializationList(req);
    });
  }

  onChangeDropdownItemBrnanch(DataBranchList? item) {
    setState(() {
      _selectedBranch = item!;
    });
  }

  onChangeDropdownItemDegree(DataDegreeList? item) {
    setState(() {
      _selectedDegree = item!;
      getFaculty(item.id);
    });
  }

  //
  onChangeDropdownItemSpe(SpecializationModel? seletedSpe) {
    setState(() {
      _selectedSpecialization = seletedSpe!;
      _timeStudyList = _specializationList[0].timeStudiesList;
      _dropdownMenuItemsTime = buildDropdownMenuItemTime(_timeStudyList);
      _selectTime = _dropdownMenuItemsTime[0].value!;
      _choosePriceList = _specializationList[0].priceChooseList;
      _dropdownMenuItemsPrice = buildDropdownMenuItemPrice(_choosePriceList);
      _selectPrice = _dropdownMenuItemsPrice[0].value!;
    });
  }

  //
  onChangeDropdownItemTime(TimeStudyModel? selectedTime) {
    setState(() {
      _selectTime = selectedTime!;
    });
  }

  //
  onChangeDropdownItemPrice(PriceChooseModel? selectedPrice) {
    setState(() {
      _selectPrice = selectedPrice!;
    });
  }

  void submitStudyTo() async {
    setState(() {
      isSummit = true;
    });
    Future.delayed(const Duration(seconds: 2), () async {
      RegisterSubmitStudyReq req = RegisterSubmitStudyReq(
          brandId: _selectedBranch!.id,
          departmentId: _selectedSpecialization!.id,
          degreeId: _selectedDegree!.id,
          facultyId: _selectedFaculty!.id,
          chooseAcademicPrice: _selectPrice.price,
          studyTimeId: _selectTime.id,
          studentTemId: registerSubmitRes.studentTemId!);

      await registerService.postSubmitRegisterStudy(req);
      RegisterSubmitStudyRes registerSubmitStudyRes =
          registerService.registerSubmitStudyRes;
      // ignore: unnecessary_null_comparison
      if (registerSubmitStudyRes.studentTemId != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentGetWay(
              registerSubmitRes: registerSubmitRes,
              registerSubmitStudyRes: registerSubmitStudyRes,
            ),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showAlertDialogConfirmSignUp(context, "ព្យាយាមម្តងទៀត");
      }
      setState(() {
        isSummit = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
        centerTitle: true,
        title: Text(
          LocaleKeys.registerStepTwo.tr(),
          style: TextStyle(fontSize: fontsize),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: SafeArea(
        child: loading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        LocaleKeys.campus.tr(),
                        style: TextStyle(fontSize: fontsize),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        //color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              style: TextStyle(
                                  fontSize: fontsize, color: Colors.black),
                              isExpanded: true,
                              iconSize: fontsize,
                              iconEnabledColor: Colors.blue,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                                size: fontsize,
                              ),
                              value: _selectedBranch,
                              items: _dropdownMenuItemsBranch,
                              onChanged: onChangeDropdownItemBrnanch),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        LocaleKeys.degree.tr(),
                        style: TextStyle(fontSize: fontsize),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            style: TextStyle(
                                fontSize: fontsize, color: Colors.black),
                            isExpanded: true,
                            // isDense: true,
                            iconSize: 35,
                            iconEnabledColor: Colors.blue,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                              size: fontsize,
                            ),
                            value: _selectedDegree,
                            items: _dropdownMenuItemsDegree,
                            onChanged: onChangeDropdownItemDegree,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(LocaleKeys.faculty.tr(),
                          style: TextStyle(fontSize: fontsize)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: fontsize, color: Colors.black),
                            // isDense: true,
                            iconSize: 35,
                            iconEnabledColor: Colors.blue,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                              size: fontsize,
                            ),
                            value: _selectedFaculty,
                            items: _dropdownMenuItemsFaculty,
                            onChanged: onChangeDropdownItemFaculty,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(LocaleKeys.fieldSkill.tr(),
                          style: TextStyle(fontSize: fontsize)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: fontsize, color: Colors.black),
                            // isDense: true,
                            iconSize: fontsize,
                            iconEnabledColor: Colors.blue,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                              size: fontsize,
                            ),
                            value: _selectedSpecialization,
                            items: _dropdownMenuItemsSpecialization,
                            onChanged: onChangeDropdownItemSpe,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(LocaleKeys.studyTime.tr(),
                          style: TextStyle(
                              fontSize: fontsize, color: Colors.black)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.grey[100],
                            isExpanded: true,
                            // isDense: true,
                            style: TextStyle(
                                fontSize: fontsize, color: Colors.black),
                            iconSize: fontsize,
                            iconEnabledColor: Colors.blue,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                              size: fontsize,
                            ),
                            value: _selectTime,
                            items: _dropdownMenuItemsTime,
                            onChanged: onChangeDropdownItemTime,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        LocaleKeys.chooseAcademicPrice.tr(),
                        style: TextStyle(fontSize: fontsize),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.grey[100],
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: fontsize, color: Colors.black),
                            // isDense: true,
                            iconSize: fontsize,
                            iconEnabledColor: Colors.blue,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                              size: fontsize,
                            ),
                            value: _selectPrice,
                            items: _dropdownMenuItemsPrice,
                            onChanged: onChangeDropdownItemPrice,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.indigo[900],
                          textStyle: TextStyle(fontSize: fontsize),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.indigo[900],
                        ),
                        onPressed: () {
                          submitStudyTo();
                        },
                        child: Text(
                          LocaleKeys.nextGo.tr(),
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

  showAlertDialogConfirmSignUp(BuildContext context, String message) {
    final height = MediaQuery.of(context).size.height;
    var fontsize = height * 0.027;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        LocaleKeys.cancel.tr(),
        style: TextStyle(fontSize: fontsize),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(LocaleKeys.accept.tr(), style: TextStyle(fontSize: fontsize)),
      onPressed: () {
        submitStudyTo();
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("${LocaleKeys.message.tr()}...",
          style: TextStyle(fontSize: fontsize)),
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
}
