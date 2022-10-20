import 'package:habit_tracker_app/model/entities/repeat.dart';

class Habit {
  final int idHabit;
  final int idRepeat;
  final String habitName;
  final DateTime startDate;
  final String note;
  final String image;
  final int? nbDateFinish;
  final DateTime? endDate;

  Habit(
      {required this.idHabit,
      required this.habitName,
      required this.startDate,
      required this.note,
      required this.image,
      this.nbDateFinish,
      this.endDate,
      required this.idRepeat});

  Habit.fromMap(Map<String, dynamic> data)
      : idHabit = data["idHabit"],
        habitName = data["habitName"],
        startDate = data["startDate"],
        note = data["note"],
        image = data["image"],
        nbDateFinish = data["nbDateFinish"],
        endDate = data["endDate"],
        idRepeat = data["Fk_idRepeat"];

  Map<String, Object?> toMap() {
    return {
      'idHabit': idHabit,
      'habitName': habitName,
      'startDate': startDate,
      'note': note,
      'image': image,
      'nbDateFinish': nbDateFinish,
      'endDate': endDate,
      'Fk_idRepeat': idRepeat,
    };
  }
}
