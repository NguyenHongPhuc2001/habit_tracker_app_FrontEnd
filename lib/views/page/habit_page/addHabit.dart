import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/dao/time_of_days_dao.dart';
import 'package:habit_tracker_app/dao/time_of_week_dao.dart';
import 'package:habit_tracker_app/model/database/database_handler.dart';
import 'package:habit_tracker_app/model/entities/habit.dart';
import 'package:habit_tracker_app/model/entities/timeOfDays.dart';
import 'package:habit_tracker_app/model/entities/timeOfWeek.dart';
import 'package:habit_tracker_app/views/page/habit_page/repeat_selection_page.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({
    Key? key,
  }) : super(key: key);

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  var repeatValue = 'Hằng ngày';
  var timesValue = 'Once';
  var reminderValue = 'Off';
  var imageFile;

  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  TextEditingController _habitNameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _nbDateController = TextEditingController();
  DateFormat df = DateFormat("yyyy-MM-dd");
  DateFormat tf = DateFormat.jm();

  String startDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String endDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String reminder = "10:00 AM";

  bool KTGSwitchBox = false,
      tabSelected_1 = true,
      tabSelected_2 = false,
      LNNSwitchBox = false,
      todCheck = false,
      towCheck = false,
      checkValue = false;

  String checkType = "";
  List<TimeOfDays> lsToD = TimeOfDaysDao().getAll();
  List<TimeOfWeeks> lsToW = TimeOfWeeksDAO().getAll();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    reminderValue = time.format(context);
    TimeOfDays timeOfDays = _getToD(lsToD);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          leading: IconButton(
            splashRadius: 30,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey.shade600,
            ),
          ),
          title: Center(
            child: Text(
              "Tạo thói quen",
              style: TextStyle(
                color: Colors.grey.shade900,
              ),
            ),
          ),
          titleTextStyle: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
          actions: [
            IconButton(
              splashRadius: 30,
              icon: Icon(
                Icons.save,
                size: 30,
                color: Colors.grey.shade600,
              ),
              onPressed: () {
               _saveHabit();
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                width: size.width,
                height: size.width * 0.4,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff00f5d4),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: InkWell(
                    onTap: () {
                      _showCustomDialog(context);
                    },
                    child: imageFile != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: Image.file(imageFile).image,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                NetworkImage("https://picsum.photos/200/200"),
                            radius: 50,
                          ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Tên",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Nhập tên thói quen",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Ghi chú",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: "Ghi chú (Không bắt buộc)",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Ngày bắt đầu",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.grey,
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            DateTime valueDate = await _showDateTimePicker();
                            setState(() {
                              startDate = df.format(valueDate).toString();
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: Colors.grey.shade500,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  startDate,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                width: size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Khoảng thời gian",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Switch(
                          activeColor: Colors.green,
                          value: KTGSwitchBox,
                          onChanged: (value) {
                            setState(() {
                              KTGSwitchBox = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible: KTGSwitchBox,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.grey,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade300,
                              ),
                              width: size.width,
                              child: DefaultTabController(
                                length: 2,
                                child: TabBar(
                                  indicator: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  unselectedLabelColor: Colors.grey.shade700,
                                  onTap: (value) {
                                    setState(() {
                                      if (value == 0) {
                                        tabSelected_1 = true;
                                        tabSelected_2 = false;
                                      } else {
                                        tabSelected_1 = false;
                                        tabSelected_2 = true;
                                      }
                                    });
                                  },
                                  tabs: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 3, bottom: 3),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Ngày",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 3, bottom: 3),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Ngày cuối",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20,
                              ),
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: tabSelected_1,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                            color: Colors.orange,
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.flag_outlined,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: tabSelected_2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          DateTime valueDate =
                                              await _showDateTimePicker();
                                          setState(() {
                                            endDate =
                                                df.format(valueDate).toString();
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month_sharp,
                                              color: Colors.grey.shade500,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 15,
                                              ),
                                              child: Text(
                                                endDate,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: size.width,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lời nhắc nhở",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Switch(
                          activeColor: Colors.green,
                          value: LNNSwitchBox,
                          onChanged: (value) {
                            setState(() {
                              LNNSwitchBox = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible: LNNSwitchBox,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            _showTimePicker();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.clock,
                                  size: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    reminder,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Lặp lại",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 5,
                            color: Colors.grey.shade500,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              final checkData = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RepeatSelectionPage(
                                    listToD: lsToD,
                                    listToW: lsToW,
                                  ),
                                ),
                              ).then(
                                (value) {
                                  setState(() {});
                                  checkType = value;
                                  _checkRepeat(checkType);
                                  print(
                                      "Type check after async : ${checkType}");
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: size.width*0.6,
                                    child: Text(
                                      checkType == "" ? "Chọn khoảng thời gian lặp lại" : checkType,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: todCheck,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 7, bottom: 7),
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  timeOfDays.nameToD,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: towCheck,
                            child: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Container(
                                width: size.width,
                                height: size.height * 0.07,
                                child: ListView.separated(
                                  shrinkWrap: false,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: lsToW.length,
                                  itemBuilder: (context, index) {
                                    return lsToW.elementAt(index).selected
                                        ? Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(13),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.orange,
                                            ),
                                            child: Text(
                                              _fillDayOfWeek(
                                                  lsToW.elementAt(index)),
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(13),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade300,
                                            ),
                                            child: Text(
                                              _fillDayOfWeek(
                                                  lsToW.elementAt(index)),
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(width: size.width * 0.032);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //methods
  Future<void> saveHabit(Habit habit) async {
    Database db = await DatabaseHandler().initDatabase();
    db.insert('Habit', habit.toMap());
    print("Save successfully !");
  }

  _getImageFromGallery() async {
    Size size = MediaQuery.of(context).size;
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: size.width * 0.4,
      maxHeight: size.width * 0.4,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        Navigator.of(context).pop();
      });
    }
  }

  _getImageFromCamera() async {
    Size size = MediaQuery.of(context).size;
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: size.width * 0.4,
      maxHeight: size.width * 0.4,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        Navigator.of(context).pop();
      });
    }
  }

  _showCustomDialog(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              "Chọn hình ảnh",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            content: Container(
              width: size.width * 0.8,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: size.width * 0.25,
                    height: size.width * 0.3,
                    child: GestureDetector(
                      onTap: () {
                        _getImageFromCamera();
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.grey,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera,
                                size: 35,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Camera",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.25,
                    height: size.width * 0.3,
                    child: GestureDetector(
                      onTap: () {
                        _getImageFromGallery();
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.grey,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.image,
                                size: 35,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Gallery",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<DateTime> _showDateTimePicker() async {
    DateTime dateAfter = DateTime.now();
    await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2022, 9, 19),
      maxTime: DateTime(2022, 12, 31),
      onConfirm: (valueDate) {
        setState(() {
          // dateValue = df.format(valueDate).toString();
          dateAfter = valueDate;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
    return dateAfter;
  }

  _showTimePicker() async {
    DatePicker.showTimePicker(context, showTitleActions: true,
        onConfirm: (valueDate) {
      setState(() {
        reminder = tf.format(valueDate).toString();
        print(reminder);
      });
    });
  }

  TimeOfDays _getToD(List<TimeOfDays> listValue) {
    TimeOfDays tod =
        TimeOfDays(idToD: 1, nameToD: "initial", nbDays: 1, selected: true);
    listValue.forEach((element) {
      if (element.selected == true)
        setState(() {
          tod = element;
        });
    });
    return tod;
  }

  _fillDayOfWeek(TimeOfWeeks toWValue) {
    String nameOfDate = "";
    if (toWValue.dateValue == 1)
      return nameOfDate = "M";
    else if (toWValue.dateValue == 2)
      return nameOfDate = "T";
    else if (toWValue.dateValue == 3)
      return nameOfDate = "W";
    else if (toWValue.dateValue == 4)
      return nameOfDate = "T";
    else if (toWValue.dateValue == 5)
      return nameOfDate = "F";
    else if (toWValue.dateValue == 6)
      return nameOfDate = "S";
    else
      return nameOfDate = "S";
  }

  _checkRepeat(String value) {
    if (value == "Khoảng thời gian") {
      towCheck = false;
      return todCheck = true;
    } else if (value == "Tuần") {
      todCheck = false;
      return towCheck = true;
    } else {
      todCheck = false;
      towCheck = false;
      return false;
    }
  }

  void _saveHabit() {

  }

//end methods

}
