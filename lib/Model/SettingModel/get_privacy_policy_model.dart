class GetPrivacyPolicyModel {
  GetPrivacyPolicyModel({
    required this.message,
    required this.data,
  });

  final String? message;
  final List<PrivacyData>? data;


  factory GetPrivacyPolicyModel.fromJson(Map<String, dynamic> json){
    return GetPrivacyPolicyModel(
      message: json["message"],
      data: json["data"] == null ? [] : [PrivacyData.fromJson(json['data'])],

    );
  }

}

class PrivacyData {
  PrivacyData({
    required this.title,
    required this.content,
  });

  final String? title;
  final String? content;

  factory PrivacyData.fromJson(Map<String, dynamic> json){
    return PrivacyData(
      title: json["title"],
      content: json["content"],
    );
  }

}
