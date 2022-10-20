import 'package:habit_tracker_app/model/entities/timeOfWeek.dart';

class TimeOfWeeksDAO {
  TimeOfWeeks tow1 = TimeOfWeeks(
    idToW: 1,
    nameToW: "Thứ hai",
    selected: false,
    dateValue: 1,
  );
  TimeOfWeeks tow2 = TimeOfWeeks(
    idToW: 2,
    nameToW: "Thứ ba",
    selected: false,
    dateValue: 2,
  );
  TimeOfWeeks tow3 = TimeOfWeeks(
    idToW: 3,
    nameToW: "Thứ tư",
    selected: false,
    dateValue: 3,
  );
  TimeOfWeeks tow4 = TimeOfWeeks(
    idToW: 4,
    nameToW: "Thứ năm",
    selected: false,
    dateValue: 4,
  );
  TimeOfWeeks tow5 = TimeOfWeeks(
    idToW: 5,
    nameToW: "Thứ sáu",
    selected: false,
    dateValue: 5,
  );
  TimeOfWeeks tow6 = TimeOfWeeks(
    idToW: 6,
    nameToW: "Thứ bảy",
    selected: false,
    dateValue: 6,
  );
  TimeOfWeeks tow7 = TimeOfWeeks(
    idToW: 7,
    nameToW: "Chủ nhật",
    selected: false,
    dateValue: 7,
  );

  List<TimeOfWeeks> getAll(){
    List<TimeOfWeeks> list = [];
    list.add(tow1);
    list.add(tow2);
    list.add(tow3);
    list.add(tow4);
    list.add(tow5);
    list.add(tow6);
    list.add(tow7);
    return list;
  }


}
