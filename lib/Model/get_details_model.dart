class GetDetailsModel {
  GetDetailsModel({
    required this.success,
    required this.data,
  });

  final bool? success;
  final List<DetailsData> data;

  factory GetDetailsModel.fromJson(Map<String, dynamic> json){
    return GetDetailsModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<DetailsData>.from(json["data"]!.map((x) => DetailsData.fromJson(x))),
    );
  }

}

class DetailsData {
  DetailsData({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.videoPath,
    required this.status,
    required this.image,
    required this.trainerName,
    required this.createdAt,
    required this.updatedAt,
    required this.questionId,
  });

  final int? id;
  final int? categoryId;
  final String? title;
  final String? description;
  final String? videoPath;
  final int? status;
  final String? image;
  final String? trainerName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? questionId;

  factory DetailsData.fromJson(Map<String, dynamic> json){
    return DetailsData(
      id: json["id"],
      categoryId: json["category_id"],
      title: json["title"],
      description: json["description"],
      videoPath: json["video_path"],
      status: json["status"],
      image: json["image"],
      trainerName: json["trainer_name"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      questionId: json["question_id"],
    );
  }

}
