class FaqModel {
  String faqid;
  String question;
  String answer;

  FaqModel({required this.faqid, required this.answer, required this.question});

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
        faqid: json['faqid'],
        question: json['question'],
        answer: json['answer']);
  }
}
