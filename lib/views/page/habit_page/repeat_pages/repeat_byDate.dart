import 'package:flutter/material.dart';
import 'package:habit_tracker_app/dao/time_of_days_dao.dart';
import 'package:habit_tracker_app/model/entities/timeOfDays.dart';
import 'package:habit_tracker_app/model/entities/timeOfWeek.dart';

class RepeatByDate extends StatefulWidget {
  final List<TimeOfDays> listToD;
  final List<TimeOfWeeks> listToW;

  const RepeatByDate({
    Key? key,
    required this.listToD,
    required this.listToW,
  }) : super(key: key);

  @override
  State<RepeatByDate> createState() => _RepeatByDateState();
}

class _RepeatByDateState extends State<RepeatByDate> {
  bool tod1 = false,
      tod2 = false,
      tod3 = false,
      tod4 = false,
      tod5 = false,
      tod6 = false,
      tod7 = false,
      tod8 = false;

  @override
  Widget build(BuildContext context) {
    List<TimeOfDays> lsToD = widget.listToD;
    List<TimeOfWeeks> lsToW = widget.listToW;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: ListView.builder(
            itemCount: lsToD.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      for (var i = 0; i < widget.listToD.length; i++) {
                        if (i == index) {
                          widget.listToD.elementAt(index).selected = true;
                        } else {
                          widget.listToD.elementAt(i).selected = false;
                        }
                      }
                      lsToW.forEach((element) {
                        element.selected = false;
                      });
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
                                Icons.access_time_filled_outlined,
                                color: Colors.green,
                                size: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  lsToD.elementAt(index).nameToD,
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
                          child: lsToD.elementAt(index).selected
                              ? Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.055,
                                  height: size.width * 0.055,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.orange,
                                    size: 10,
                                  ),
                                )
                              : Container(
                                  width: size.width * 0.055,
                                  height: size.width * 0.055,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.orange,
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
  }
}
