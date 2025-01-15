class GetTrainerVideoListModel {
  GetTrainerVideoListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<TrainerVideoList> data;

  factory GetTrainerVideoListModel.fromJson(Map<String, dynamic> json){
    return GetTrainerVideoListModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<TrainerVideoList>.from(json["data"]!.map((x) => TrainerVideoList.fromJson(x))),
    );
  }

}

class TrainerVideoList {
  TrainerVideoList({
    required this.id,
    required this.categoryId,
    required this.videoPath,
    required this.createdAt,
    required this.updatedAt,
    required this.planType,
    required this.trainerId,
    required this.planName,
    required this.planAmount,
    required this.lang,
    required this.image,
    required this.videos,
  });

  final int? id;
  final int? categoryId;
  final String? videoPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? planType;
  final int? trainerId;
  final String? planName;
  final String? planAmount;
  final String? lang;
  final String? image;
  final List<String> videos;

  factory TrainerVideoList.fromJson(Map<String, dynamic> json) {
    // Handle both list and string cases for `videos`
    final rawVideos = json["videos"];
    List<String> parsedVideos = [];

    if (rawVideos is List) {
      parsedVideos = List<String>.from(rawVideos.map((x) => x.toString()));
    } else if (rawVideos is String) {
      try {
        parsedVideos = List<String>.from(
          rawVideos
              .replaceAll('[', '')
              .replaceAll(']', '')
              .split(',')
              .map((x) => x.trim()),
        );
      } catch (e) {
        print("Error parsing videos: $e");
      }
    }

    return TrainerVideoList(
      id: json["id"],
      categoryId: json["category_id"],
      videoPath: json["video_path"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      planType: json["plan_type"],
      trainerId: json["trainer_id"],
      planName: json["plan_name"],
      planAmount: json["plan_amount"],
      lang: json["lang"],
      image: json["image"],
      videos: parsedVideos,
    );
  }
}

