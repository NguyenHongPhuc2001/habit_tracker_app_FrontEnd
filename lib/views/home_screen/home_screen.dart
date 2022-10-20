import 'package:flutter/material.dart';
import 'package:habit_tracker_app/dao/time_of_days_dao.dart';
import 'package:habit_tracker_app/dao/time_of_week_dao.dart';
import 'package:habit_tracker_app/model/entities/timeOfDays.dart';
import 'package:habit_tracker_app/model/entities/timeOfWeek.dart';
import 'package:habit_tracker_app/views/page/calendar_page/calendar_page.dart';
import 'package:habit_tracker_app/views/page/habit_page/addHabit.dart';
import 'package:habit_tracker_app/views/page/habit_page/habit_page.dart';
import 'package:habit_tracker_app/views/page/person_page/person_page.dart';
import 'package:habit_tracker_app/views/page/report_page/report_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pages = [
    HabitPage(),
    ReportPage(),
    CalendarPage(),
    PersonPage(),
  ];

  final PageController _pageController = PageController(initialPage: 0);
  var _selectedIndex = 0;
  bool _item1 = true, _item2 = false, _item3 = false, _item4 = false;

  @override
  Widget build(BuildContext context) {
    List<TimeOfDays> lsToD = TimeOfDaysDao().getAll();
    List<TimeOfWeeks> lsToW = TimeOfWeeksDAO().getAll();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: PageView(
          onPageChanged: (value) {},
          controller: _pageController,
          children: _pages,
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddHabit(
                ),
              ),
            );
          },
          child: Container(
            width: size.width * 0.2,
            height: size.width * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.orangeAccent.shade700,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                )
              ],
            ),
            child: Icon(
              Icons.add,
              color: Colors.orangeAccent.shade700,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            width: size.width,
            height: size.width * 0.16,
            decoration:
                BoxDecoration(color: Colors.orangeAccent.shade200, boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(0, -1),
                blurRadius: 20,
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _itemBottomBar(
                  onTap: () {
                    setState(() {
                      _item1 = true;
                      _item2 = false;
                      _item3 = false;
                      _item4 = false;
                      _selectedIndex = 0;
                      _onTap(_selectedIndex);
                    });
                  },
                  icon: _item1
                      ? Icon(
                          Icons.list_alt,
                          color: Colors.white,
                          size: 25,
                        )
                      : Icon(
                          Icons.list_alt,
                          color: Colors.grey.shade600,
                          // size: 25,
                        ),
                  text: _item1
                      ? Text(
                          "Thói quen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Thói quen",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                ),
                _itemBottomBar(
                  onTap: () {
                    setState(() {
                      _item1 = false;
                      _item2 = true;
                      _item3 = false;
                      _item4 = false;
                      _selectedIndex = 1;
                      _onTap(_selectedIndex);
                    });
                  },
                  icon: _item2
                      ? Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.bar_chart,
                          color: Colors.grey.shade600,
                          size: 25,
                        ),
                  text: _item2
                      ? Text(
                          "Thống kê",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Thống kê",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                _itemBottomBar(
                  onTap: () {
                    setState(() {
                      _item1 = false;
                      _item2 = false;
                      _item3 = true;
                      _item4 = false;
                      _selectedIndex = 2;
                      _onTap(_selectedIndex);
                    });
                  },
                  icon: _item3
                      ? Icon(
                          Icons.calendar_month_sharp,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.calendar_month_sharp,
                          color: Colors.grey.shade600,
                          size: 25,
                        ),
                  text: _item3
                      ? Text(
                          "Lịch",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Lịch",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                ),
                _itemBottomBar(
                  onTap: () {
                    setState(() {
                      _item1 = false;
                      _item2 = false;
                      _item3 = false;
                      _item4 = true;
                      _selectedIndex = 3;
                      _onTap(_selectedIndex);
                    });
                  },
                  icon: _item4
                      ? Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.more_vert,
                          color: Colors.grey.shade600,
                          size: 25,
                        ),
                  text: _item4
                      ? Text(
                          "Nhiều hơn",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Nhiều hơn",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    this.setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}

class _itemBottomBar extends StatelessWidget {
  const _itemBottomBar({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final Text text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.165,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(
              height: 5,
            ),
            text,
          ],
        ),
      ),
    );
  }
}
