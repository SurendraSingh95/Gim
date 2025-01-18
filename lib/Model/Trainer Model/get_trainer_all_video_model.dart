// class GetTrainerVideoListModel {
//   GetTrainerVideoListModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   final bool? status;
//   final String? message;
//   final List<TrainerVideoList> data;
//
//   factory GetTrainerVideoListModel.fromJson(Map<String, dynamic> json){
//     return GetTrainerVideoListModel(
//       status: json["status"],
//       message: json["message"],
//       data: json["data"] == null ? [] : List<TrainerVideoList>.from(json["data"]!.map((x) => TrainerVideoList.fromJson(x))),
//     );
//   }
//
// }
//
// class TrainerVideoList {
//   TrainerVideoList({
//     required this.id,
//     required this.categoryId,
//     required this.videoPath,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.planType,
//     required this.trainerId,
//     required this.planName,
//     required this.planAmount,
//     required this.lang,
//     required this.image,
//     required this.videos,
//   });
//
//   final int? id;
//   final int? categoryId;
//   final String? videoPath;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? planType;
//   final int? trainerId;
//   final String? planName;
//   final String? planAmount;
//   final String? lang;
//   final String? image;
//   final List<String> videos;
//
//   factory TrainerVideoList.fromJson(Map<String, dynamic> json) {
//     // Handle both list and string cases for `videos`
//     final rawVideos = json["videos"];
//     List<String> parsedVideos = [];
//
//     if (rawVideos is List) {
//       parsedVideos = List<String>.from(rawVideos.map((x) => x.toString()));
//     } else if (rawVideos is String) {
//       try {
//         parsedVideos = List<String>.from(
//           rawVideos
//               .replaceAll('[', '')
//               .replaceAll(']', '')
//               .split(',')
//               .map((x) => x.trim()),
//         );
//       } catch (e) {
//         print("Error parsing videos: $e");
//       }
//     }
//
//     return TrainerVideoList(
//       id: json["id"],
//       categoryId: json["category_id"],
//       videoPath: json["video_path"],
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//       planType: json["plan_type"],
//       trainerId: json["trainer_id"],
//       planName: json["plan_name"],
//       planAmount: json["plan_amount"],
//       lang: json["lang"],
//       image: json["image"],
//       videos: parsedVideos,
//     );
//   }
// }
/*

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
      status: json["status"] ?? false, // Default to false if null
      message: json["message"] ?? "",  // Default to empty string if null
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
  final dynamic categoryId;
  final String? videoPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? planType;
  final int? trainerId;
  final String? planName;
  final String? planAmount;
  final String? lang;
  final String? image;
  final List<Video> videos;

  factory TrainerVideoList.fromJson(Map<String, dynamic> json){
    final rawVideos = json["videos"] ?? [];

    return TrainerVideoList(
      id: json["id"],
      categoryId: json["category_id"],
      videoPath: json["video_path"] ?? "", // Default to empty string if null
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
      planType: json["plan_type"] ?? "",
      trainerId: json["trainer_id"],
      planName: json["plan_name"] ?? "",
      planAmount: json["plan_amount"] ?? "",
      lang: json["lang"] ?? "",
      image: json["image"] ?? "",
      videos: List<Video>.from(rawVideos.map((x) => Video.fromJson(x))),
    );
  }
}

class Video {
  Video({
    required this.id,
    required this.gymVideoPackageId,
    required this.videoPath,
    required this.updatedAt,
    required this.createdAt,
    required this.status,
    required this.videoAnswers,
  });

  final int? id;
  final int? gymVideoPackageId;
  final String? videoPath;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? status;
  final List<VideoAnswer> videoAnswers;

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json["id"],
      gymVideoPackageId: json["gym_video_package_id"],
      videoPath: json["video_path"] ?? "", // Default to empty string if null
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
      status: json["status"],
      videoAnswers: json["video_answers"] == null ? [] : List<VideoAnswer>.from(json["video_answers"]!.map((x) => VideoAnswer.fromJson(x))),
    );
  }
}

class VideoAnswer {
  VideoAnswer({
    required this.id,
    required this.videoId,
    required this.time,
    required this.answers,
    required this.updatedAt,
    required this.createdAt,
    required this.read,
  });

  final int? id;
  final int? videoId;
  final String? time;
  final String? answers;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? read;

  factory VideoAnswer.fromJson(Map<String, dynamic> json){
    return VideoAnswer(
      id: json["id"],
      videoId: json["video_id"],
      time: json["time"] ?? "", // Default to empty string if null
      answers: json["answers"] ?? "", // Default to empty string if null
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
      read: json["read"],
    );
  }
}*/


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
  final dynamic categoryId;
  final String? videoPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? planType;
  final int? trainerId;
  final String? planName;
  final String? planAmount;
  final String? lang;
  final String? image;
  final List<Video> videos;

  factory TrainerVideoList.fromJson(Map<String, dynamic> json){
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
      videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
    );
  }

}

class Video {
  Video({
    required this.id,
    required this.gymVideoPackageId,
    required this.videoPath,
    required this.updatedAt,
    required this.createdAt,
    required this.status,
    required this.videoAnswers,
  });

  final int? id;
  final int? gymVideoPackageId;
  final String? videoPath;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? status;
  final List<VideoAnswer> videoAnswers;

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json["id"],
      gymVideoPackageId: json["gym_video_package_id"],
      videoPath: json["video_path"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      status: json["status"],
      videoAnswers: json["video_answers"] == null ? [] : List<VideoAnswer>.from(json["video_answers"]!.map((x) => VideoAnswer.fromJson(x))),
    );
  }

}

class VideoAnswer {
  VideoAnswer({
    required this.id,
    required this.videoId,
    required this.time,
    required this.answers,
    required this.updatedAt,
    required this.createdAt,
    required this.read,
  });

  final int? id;
  final int? videoId;
  final int? time;
  final String? answers;
  final DateTime? updatedAt;
  final DateTime? createdAt;
   int? read;

  factory VideoAnswer.fromJson(Map<String, dynamic> json){
    return VideoAnswer(
      id: json["id"],
      videoId: json["video_id"],
      time: json["time"] == null? null: int.tryParse(json["time"]??'0'),
      answers: json["answers"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      read: json["read"],
    );
  }

}

