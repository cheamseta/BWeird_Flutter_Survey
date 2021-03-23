class Questionair {
  final String type;
  final String questionKh;
  final String questionEn;
  final List? answers;

  Questionair(this.type, this.questionKh, this.questionEn, this.answers);
  Questionair.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        questionKh = json['questionKh'],
        questionEn = json['questionEn'],
        answers = json['answers'];
}
