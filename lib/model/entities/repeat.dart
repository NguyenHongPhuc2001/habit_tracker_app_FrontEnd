import 'package:habit_tracker_app/model/entities/habit.dart';

class Repeat {
  final int? idRepeat;
  final int nbOfDateRepeat;
  final List<DateTime> listOfDate;
  final DateTime timeRepeat;


  Repeat({
    this.idRepeat,
    required this.nbOfDateRepeat,
    required this.listOfDate,
    required this.timeRepeat,
  });

  Repeat.fromMap(Map<String, dynamic> data)
      : idRepeat = data["idRepeat"],
        nbOfDateRepeat = data["timePerDay"],
        listOfDate = data["listOfDate"],
        timeRepeat = data["timeRepeat"];

  Map<String, dynamic> toMap() {
    return {
      'idRepeat': idRepeat,
      'timePerDay': nbOfDateRepeat,
      'listOfDate': listOfDate,
      'timeRepeat': timeRepeat,
    };
  }
}
