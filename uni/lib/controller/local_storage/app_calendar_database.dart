import 'package:sqflite/sqflite.dart';
import 'package:uni/controller/local_storage/app_database.dart';
import 'package:uni/model/entities/calendar_event.dart';

class CalendarDatabase extends AppDatabase {
  CalendarDatabase()
      : super('calendar.bd', [
          '''
          CREATE TABLE CALENDAR(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            date TEXT)'''
        ]);

  void saveCalendar(List<CalendarEvent> calendar) async {
    final Database db = await getDatabase();
    db.transaction((txn) async {
      await txn.delete('CALENDAR');
      for (var event in calendar) {
        await txn.insert('CALENDAR', event.toMap());
      }
    });
  }

  //Returns a list with all calendar events stored in the database
  Future<List<CalendarEvent>> calendar() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('calendar');

    return List.generate(maps.length, (i) {
      return CalendarEvent(maps[i]['name'], maps[i]['date']);
    });
  }
}
