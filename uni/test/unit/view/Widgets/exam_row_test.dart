

void main() {
  // group('ExamRow', () {
  //   const subject = 'SOPE';
  //   final DateTime begin = DateTime(
  //       DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0);
  //   final DateTime end = DateTime(
  //       DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0);
  //   final String beginTime = DateFormat('HH:mm').format(begin);
  //   final String endTime = DateFormat('HH:mm').format(end);
  //   testWidgets('When given a single room', (WidgetTester tester) async {
  //     final rooms = ['B315'];
  //     final Exam exam =
  //         Exam('1230', begin, end, subject, rooms, '', 'feup');
  //     final widget = makeTestableWidget(
  //         child: ExamRow(
  //       exam: exam,
  //       teacher: '',
  //       mainPage: true,
  //     ));
  //
  //     await tester.pumpWidget(widget);
  //     final roomsKey =
  //         '$subject-$rooms-$beginTime-$endTime';
  //
  //     expect(
  //         find.descendant(
  //             of: find.byKey(Key(roomsKey)), matching: find.byType(Text)),
  //         findsOneWidget);
  //   });
  //
  //   testWidgets('When given multiple rooms', (WidgetTester tester) async {
  //     final rooms = ['B315', 'B316', 'B317'];
  //     final Exam exam =
  //         Exam('1230',begin, end, subject, rooms, '', 'feup');
  //     final widget = makeTestableWidget(
  //         child: ExamRow(
  //       exam: exam,
  //       teacher: '',
  //       mainPage: true,
  //     ));
  //
  //     await tester.pumpWidget(widget);
  //     final roomsKey = '$subject-$rooms-$beginTime-$endTime';
  //
  //     expect(
  //         find.descendant(
  //             of: find.byKey(Key(roomsKey)), matching: find.byType(Text)),
  //         findsNWidgets(3));
  //   });
  // });
}
