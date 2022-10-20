import 'package:habit_tracker_app/model/database/database_handler.dart';
import 'package:habit_tracker_app/model/entities/habit.dart';
import 'package:sqflite/sqflite.dart';

class HabitDAO {

  //insert
  Future<int> insertHabit(Habit habit) async {
    int result = 0;
    final Database db = await DatabaseHandler().initDatabase();
    result = await db.insert('Habit', habit.toMap());
    return result;
  }

  //getdata
  Future<List<Habit>> getListHabit() async {
    final Database db = await DatabaseHandler().initDatabase();

    List<Map<String, Object?>> listData = await db.query('Habit');
    return listData.map((e) => Habit.fromMap(e)).toList();
  }

  //delete
  Future<void> deleteHabit(int idHabit) async {
    final Database db = await DatabaseHandler().initDatabase();
    await db.delete(
      'Habit',
      where: "idHabit = ?",
      whereArgs: [idHabit],
    );
  }
}
