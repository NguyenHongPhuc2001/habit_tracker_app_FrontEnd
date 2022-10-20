import 'package:flutter/material.dart';
import 'package:habit_tracker_app/dao/habit_dao.dart';
import 'package:habit_tracker_app/model/entities/habit.dart';
import 'package:habit_tracker_app/views/home_screen/background.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  final DateTime now = DateTime.now();

  // Future<List<Habit>> getListHabit() async {
  //   List<Habit> ls = await HabitDAO().getListHabit();
  //   return ls;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String toDay = DateFormat("EEEE, dd/MMMM/yyyy").format(now);

    // List<Habit> listHabit = getListHabit() as List<Habit>;

    return HomeBackground(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: size.width * 0.15,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  toDay,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: size.width,
            height: size.width * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Xin chào !",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Xây dựng thói quen hằng ngày!",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: size.width * 0.9,
            height: size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0),
                  blurRadius: 8,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Thói quen hôm nay",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: 0.5,
                  height: size.width * 0.05,
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://picsum.photos/200/200"),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Text(
                                  "Tập thể dục",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
