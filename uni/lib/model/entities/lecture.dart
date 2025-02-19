import 'package:logger/logger.dart';
import 'package:uni/model/entities/time_utilities.dart';

/// Stores information about a lecture.
class Lecture {
  String subject;
  String startTime;
  String endTime;
  String typeClass;
  String room;
  String teacher;
  String classNumber;
  int day;
  int blocks;
  int startTimeSeconds;
  int occurrId;

  /// Creates an instance of the class [Lecture].
  Lecture(
      this.subject,
      this.typeClass,
      this.day,
      this.blocks,
      this.room,
      this.teacher,
      this.classNumber,
      int startTimeHours,
      int startTimeMinutes,
      int endTimeHours,
      int endTimeMinutes,
      this.occurrId)
      : startTime = '${startTimeHours.toString().padLeft(2, '0')}h'
            '${startTimeMinutes.toString().padLeft(2, '0')}',
        endTime = '${endTimeHours.toString().padLeft(2, '0')}h'
            '${endTimeMinutes.toString().padLeft(2, '0')}',
        startTimeSeconds = 0;

  factory Lecture.fromApi(
      String subject,
      String typeClass,
      int day,
      int startTimeSeconds,
      int blocks,
      String room,
      String teacher,
      String classNumber,
      int occurrId) {
    final startTimeHours = (startTimeSeconds ~/ 3600);
    final startTimeMinutes = ((startTimeSeconds % 3600) ~/ 60);
    final endTimeSeconds = 60 * 30 * blocks + startTimeSeconds;
    final endTimeHours = (endTimeSeconds ~/ 3600);
    final endTimeMinutes = ((endTimeSeconds % 3600) ~/ 60);
    final lecture = Lecture(
        subject,
        typeClass,
        day,
        blocks,
        room,
        teacher,
        classNumber,
        startTimeHours,
        startTimeMinutes,
        endTimeHours,
        endTimeMinutes,
        occurrId);
    lecture.startTimeSeconds = startTimeSeconds;
    return lecture;
  }

  factory Lecture.fromHtml(
      String subject,
      String typeClass,
      int day,
      String startTime,
      int blocks,
      String room,
      String teacher,
      String classNumber,
      int occurrId) {
    final startTimeHours = int.parse(startTime.substring(0, 2));
    final startTimeMinutes = int.parse(startTime.substring(3, 5));
    final endTimeHours =
        (startTimeMinutes + (blocks * 30)) ~/ 60 + startTimeHours;
    final endTimeMinutes = (startTimeMinutes + (blocks * 30)) % 60;
    return Lecture(
        subject,
        typeClass,
        day,
        blocks,
        room,
        teacher,
        classNumber,
        startTimeHours,
        startTimeMinutes,
        endTimeHours,
        endTimeMinutes,
        occurrId);
  }

  /// Clones a lecture from the api.
  static Lecture clone(Lecture lec) {
    return Lecture.fromApi(
        lec.subject,
        lec.typeClass,
        lec.day,
        lec.startTimeSeconds,
        lec.blocks,
        lec.room,
        lec.teacher,
        lec.classNumber,
        lec.occurrId);
  }

  /// Clones a lecture from the html.
  static Lecture cloneHtml(Lecture lec) {
    return Lecture.fromHtml(lec.subject, lec.typeClass, lec.day, lec.startTime,
        lec.blocks, lec.room, lec.teacher, lec.classNumber, lec.occurrId);
  }

  /// Converts this lecture to a map.
  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'typeClass': typeClass,
      'day': day,
      'startTime': startTime,
      'blocks': blocks,
      'room': room,
      'teacher': teacher,
      'classNumber': classNumber,
      'occurrId': occurrId
    };
  }

  /// Prints the data in this lecture to the [Logger] with an INFO level.
  printLecture() {
    Logger().i('$subject $typeClass');
    Logger().i('${TimeString.getWeekdaysStrings()[day]} $startTime $endTime $blocks blocos');
    Logger().i('$room  $teacher\n');
  }

  /// Compares the date and time of two lectures.
  int compare(Lecture other) {
    if (day == other.day) {
      return startTime.compareTo(other.startTime);
    } else {
      return day.compareTo(other.day);
    }
  }

  @override
  int get hashCode => Object.hash(subject, startTime, endTime, typeClass, room,
      teacher, day, blocks, startTimeSeconds, occurrId);

  @override
  bool operator ==(other) =>
      other is Lecture &&
      subject == other.subject &&
      startTime == other.startTime &&
      endTime == other.endTime &&
      typeClass == other.typeClass &&
      room == other.room &&
      teacher == other.teacher &&
      day == other.day &&
      blocks == other.blocks &&
      startTimeSeconds == other.startTimeSeconds &&
      occurrId == other.occurrId;
}
