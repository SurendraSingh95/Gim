class GetTrainerDetailsModel {
  GetTrainerDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<TarinerData> data;

  factory GetTrainerDetailsModel.fromJson(Map<String, dynamic> json){
    return GetTrainerDetailsModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<TarinerData>.from(json["data"]!.map((x) => TarinerData.fromJson(x))),
    );
  }

}

class TarinerData {
  TarinerData({
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

  factory TarinerData.fromJson(Map<String, dynamic> json){
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


    return TarinerData(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      type: json["type"],
      //videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x)),
      profileImage: json["profile_image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      lang: json["lang"],
      videos: parsedVideos,
    );
  }

}
