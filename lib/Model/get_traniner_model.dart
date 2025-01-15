class GetTrainerModel {
  GetTrainerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<TrainerList> data;

  factory GetTrainerModel.fromJson(Map<String, dynamic> json){
    return GetTrainerModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<TrainerList>.from(json["data"]!.map((x) => TrainerList.fromJson(x))),
    );
  }

}

class TrainerList {
  TrainerList({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.type,
    required this.videos,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.lang,
  });

  final int? id;
  final String? title;
  final String? description;
  final List<String> images;
  final String? type;
  final List<String> videos;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? lang;

  factory TrainerList.fromJson(Map<String, dynamic> json){
    return TrainerList(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      type: json["type"],
      videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x)),
      profileImage: json["profile_image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      lang: json["lang"],
    );
  }

}
