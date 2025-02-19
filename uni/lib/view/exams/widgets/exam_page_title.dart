import 'package:flutter/material.dart';
import 'package:uni/view/exams/widgets/exam_filter_menu.dart';
import 'package:uni/view/common_widgets/page_title.dart';

class ExamPageTitle extends StatelessWidget {
  const ExamPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          PageTitle(name: 'Exames', center: false, pad: false),
          Material(child: ExamFilterMenu()),
        ],
      ),
    );
  }
}
