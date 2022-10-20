class TimeOfWeeks {
  final int idToW;
  final String nameToW;
  final int dateValue;
  bool selected;

  TimeOfWeeks({
    required this.idToW,
    required this.nameToW,
    required this.selected,
    required this.dateValue,
  });

  TimeOfWeeks.fromMap(Map<String, dynamic> data)
      : idToW = data["idToW"],
        nameToW = data["nameToW"],
        dateValue = data["dateValue"],
        selected = data["selected"];

  Map<String, Object?> toMap() {
    return {
      'idToW': idToW,
      'nameToW': nameToW,
      'dateValue':dateValue,
      'selected':selected,
    };
  }
}
