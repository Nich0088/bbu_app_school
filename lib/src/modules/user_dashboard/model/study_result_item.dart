class StudyResultItem {
  final int id;
  final String term;
  final String termTitle;
  final List<Subject> subjectList;

  StudyResultItem({
    required this.id,
    required this.term,
    required this.termTitle,
    required this.subjectList,
  });
}

class Subject {
  final int numberOrder;
  final String name;
  final double midtermResult;
  final double finalResult;
  final double credit;
  final double total;
  final double gpv;
  final String grade;

  Subject({
    required this.numberOrder,
    required this.name,
    required this.midtermResult,
    required this.finalResult,
    required this.credit,
    required this.total,
    required this.gpv,
    required this.grade,
  });
}
