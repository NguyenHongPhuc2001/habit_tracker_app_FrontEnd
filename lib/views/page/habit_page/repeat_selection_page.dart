import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/entities/timeOfDays.dart';
import 'package:habit_tracker_app/model/entities/timeOfWeek.dart';
import 'package:habit_tracker_app/views/page/habit_page/addHabit.dart';
import 'package:habit_tracker_app/views/page/habit_page/repeat_pages/repeat_byCalendar.dart';
import 'package:habit_tracker_app/views/page/habit_page/repeat_pages/repeat_byDate.dart';
import 'package:habit_tracker_app/views/page/habit_page/repeat_pages/repeat_byWeek.dart';

class RepeatSelectionPage extends StatefulWidget {
  final List<TimeOfDays> listToD;
  final List<TimeOfWeeks> listToW;

  RepeatSelectionPage({
    Key? key,
    required this.listToD,
    required this.listToW,
  }) : super(key: key);

  @override
  State<RepeatSelectionPage> createState() => _RepeatSelectionPageState();
}

class _RepeatSelectionPageState extends State<RepeatSelectionPage> {
  final PageController _pageController = PageController(initialPage: 0);

  List<TimeOfDays> lsToD = [];
  List<TimeOfWeeks> lsToW = [];
  String checkRepeat = "";
  String type = "";
  TimeOfDays item =
      TimeOfDays(idToD: 1, nameToD: "1", nbDays: 1, selected: false);

  @override
  Widget build(BuildContext context) {
    lsToD = widget.listToD;
    lsToW = widget.listToW;

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Text(""),
            title: Text(
              "Lặp lại",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.xmark,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(size.width * 0.1),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                width: size.width,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.orange,
                    ),
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    tabs: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text("Theo ngày"),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text("Theo tuần"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              RepeatByDate(
                listToD: lsToD,
                listToW: lsToW,
              ),
              RepeatByWeek(
                listToW: lsToW,
                listToD: lsToD,
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    lsToD.forEach((item) {
                      if (item.selected == true) checkRepeat = "Khoảng thời gian";
                    });
                    lsToW.forEach((item) {
                      if (item.selected == true) checkRepeat = "Tuần";
                    });
                  });
                  Navigator.pop(context, checkRepeat);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 11, bottom: 11),
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.orange,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 7),
                        blurRadius: 10,
                        spreadRadius: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Text(
                    "Lưu",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// void _onTap(int index) {
//   setState(() {
//     _pageController.jumpToPage(index);
//   });
// }
}
