import 'package:flutter/material.dart';
import 'package:habit_tracker_app/dao/time_of_week_dao.dart';
import 'package:habit_tracker_app/model/entities/timeOfDays.dart';
import 'package:habit_tracker_app/model/entities/timeOfWeek.dart';

class RepeatByWeek extends StatefulWidget {
  final List<TimeOfWeeks> listToW;
  final List<TimeOfDays> listToD;

  const RepeatByWeek({
    Key? key,
    required this.listToW,
    required this.listToD,
  }) : super(key: key);

  @override
  State<RepeatByWeek> createState() => _RepeatByWeekState();
}

class _RepeatByWeekState extends State<RepeatByWeek> {
  List<TimeOfWeeks> list = TimeOfWeeksDAO().getAll();

  @override
  Widget build(BuildContext context) {
    List<TimeOfWeeks> lsToW = widget.listToW;
    List<TimeOfDays> lsToD = widget.listToD;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: ListView.builder(
            itemCount: lsToW.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      lsToW.elementAt(index).selected =
                          !lsToW.elementAt(index).selected;
                    });
                    lsToD.forEach((element) {
                      element.selected = false;
                    });
                  },
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                                size: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  lsToW.elementAt(index).nameToW,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: lsToW.elementAt(index).selected
                              ? Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.1,
                                  height: size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              : Container(
                                  width: size.width * 0.1,
                                  height: size.width * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
    ;
  }
}
