// class GetQuestionsModel {
//   GetQuestionsModel({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//
//   final bool? success;
//   final String? message;
//   final List<QuestionList> data;
//
//   factory GetQuestionsModel.fromJson(Map<String, dynamic> json){
//     return GetQuestionsModel(
//       success: json["success"],
//       message: json["message"],
//       data: json["data"] == null ? [] : List<QuestionList>.from(json["data"]!.map((x) => QuestionList.fromJson(x))),
//     );
//   }
//
// }
//
// class QuestionList {
//   QuestionList({
//     required this.id,
//     required this.questionText,
//     required this.answers,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   final int? id;
//   final String? questionText;
//   final List<Answer> answers;
//   final String? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   factory QuestionList.fromJson(Map<String, dynamic> json){
//     return QuestionList(
//       id: json["id"],
//       questionText: json["question_text"],
//       answers: json["answers"] == null ? [] : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
//       status: json["status"],
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//     );
//   }
//
// }
//
// class Answer {
//   Answer({
//     required this.key,
//     required this.value,
//   });
//
//   final dynamic key;
//   final String? value;
//
//   factory Answer.fromJson(Map<String, dynamic> json){
//     return Answer(
//       key: json["key"],
//       value: json["value"],
//     );
//   }
//
// }
class GetQuestionsModel {
  GetQuestionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<QuestionList> data;

  factory GetQuestionsModel.fromJson(Map<String, dynamic> json){
    return GetQuestionsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<QuestionList>.from(json["data"]!.map((x) => QuestionList.fromJson(x))),
    );
  }

}

class QuestionList {
  QuestionList({
    required this.id,
    required this.questionText,
    required this.cateName,
    required this.answers,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? questionText;
  final String? cateName;
  final List<Answer> answers;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory QuestionList.fromJson(Map<String, dynamic> json){
    return QuestionList(
      id: json["id"],
      questionText: json["question_text"],
      cateName: json["category_name"],
      answers: json["answers"] == null ? [] : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Answer {
  Answer({
    required this.key,
    required this.value,
  });

  final int? key;
  final dynamic value;

  factory Answer.fromJson(Map<String, dynamic> json){
    return Answer(
      key: json["key"],
      value: json["value"] == null ? null : Value.fromJson(json["value"]),
    );
  }

}

class Value {
  Value({
    required this.answer,
    required this.image,
    required this.icon,
  });

  final String? answer;
  final String? image;
  final String? icon;

  factory Value.fromJson(Map<String, dynamic> json){
    return Value(
      answer: json["answer"],
      image: json["image"],
      icon: json["icon"],
    );
  }

}
