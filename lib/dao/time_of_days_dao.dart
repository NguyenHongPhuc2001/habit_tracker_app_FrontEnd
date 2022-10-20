import 'package:habit_tracker_app/model/entities/timeOfDays.dart';

class TimeOfDaysDao {
  TimeOfDays tod1 = TimeOfDays(idToD: 1, nameToD: "Hằng ngày", nbDays: 1,selected: false);
  TimeOfDays tod2 = TimeOfDays(idToD: 2, nameToD: "Mỗi 2 ngày", nbDays: 2,selected: false);
  TimeOfDays tod3 = TimeOfDays(idToD: 3, nameToD: "Mỗi 3 ngày", nbDays: 3,selected: false);
  TimeOfDays tod4 = TimeOfDays(idToD: 4, nameToD: "Mỗi 4 ngày", nbDays: 4,selected: false);
  TimeOfDays tod5 = TimeOfDays(idToD: 5, nameToD: "Mỗi 5 ngày", nbDays: 5,selected: false);
  TimeOfDays tod6 = TimeOfDays(idToD: 6, nameToD: "Mỗi 6 ngày", nbDays: 6,selected: false);
  TimeOfDays tod7 = TimeOfDays(idToD: 7, nameToD: "Mỗi 7 ngày", nbDays: 7,selected: false);
  TimeOfDays tod8 = TimeOfDays(idToD: 8, nameToD: "Mỗi 14 ngày", nbDays: 14,selected: false);

  List<TimeOfDays> getAll()  {
    List<TimeOfDays> list = [];
    list.add(tod1);
    list.add(tod2);
    list.add(tod3);
    list.add(tod4);
    list.add(tod5);
    list.add(tod6);
    list.add(tod7);
    list.add(tod8);
    return list;
  }
}
