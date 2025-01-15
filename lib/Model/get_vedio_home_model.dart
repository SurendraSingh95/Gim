class GetVideoModel {
  GetVideoModel({
    required this.success,
    required this.data,
  });

  final bool? success;
  final List<VideoList> data;

  factory GetVideoModel.fromJson(Map<String, dynamic> json){
    return GetVideoModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<VideoList>.from(json["data"]!.map((x) => VideoList.fromJson(x))),
    );
  }

}

class VideoList {
  VideoList({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.trainer,
    required this.description,
    required this.videoPath,
    required this.status,
    required this.questionId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? categoryId;
  final String? title;
  final String? description;
  final String? trainer;
  final String? questionId;
  final String? videoPath;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory VideoList.fromJson(Map<String, dynamic> json){
    return VideoList(
      id: json["id"],
      categoryId: json["category_id"],
      title: json["title"],
      questionId: json["question_id"],
      trainer: json["trainer_name"],
      description: json["description"],
      videoPath: json["video_path"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
