class StudyItem {
  final int id;
  final String title;
  final String label;
  final bool isFixedKhmerLanguage;
  final bool isFixedEnglishLanguage;

  StudyItem({
    required this.id,
    required this.title,
    required this.label,
    this.isFixedKhmerLanguage = false,
    this.isFixedEnglishLanguage = false,
  });
}
