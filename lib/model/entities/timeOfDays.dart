class TimeOfDays {
  final int idToD;
  final String nameToD;
  final int nbDays;
  bool selected;

  TimeOfDays({
    required this.idToD,
    required this.nameToD,
    required this.nbDays,
    required this.selected,
  });

  TimeOfDays.fromMap(Map<String, dynamic> data)
      : idToD = data["idToD"],
        nameToD = data["nameToD"],
        nbDays = data["nbDays"],
        selected = data["selected"];

  Map<String, Object?> toMap() {
    return {
      'idToD': idToD,
      'nameToD': nameToD,
      'nbDays':nbDays,
      'selected':selected,
    };
  }
}
