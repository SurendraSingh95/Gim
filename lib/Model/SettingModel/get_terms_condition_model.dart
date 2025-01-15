class GetTermsAndConditionModel {
  GetTermsAndConditionModel({
    required this.message,
    required this.data,
  });

  final String? message;
  final List<TermsData>? data;


  factory GetTermsAndConditionModel.fromJson(Map<String, dynamic> json){
    return GetTermsAndConditionModel(
      message: json["message"],
      data: json["data"] == null ? [] : [TermsData.fromJson(json['data'])],
    );
  }

}

class TermsData {
  TermsData({
    required this.title,
    required this.content,
  });

  final String? title;
  final String? content;

  factory TermsData.fromJson(Map<String, dynamic> json){
    return TermsData(
      title: json["title"],
      content: json["content"],
    );
  }

}
