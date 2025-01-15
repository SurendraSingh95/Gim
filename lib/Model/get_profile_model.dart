class GetProfileModel {
  GetProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<ProfileData>? data;

  factory GetProfileModel.fromJson(Map<String, dynamic> json) {
    return GetProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : [ProfileData.fromJson(json['data'])],
    );
  }
}

class ProfileData {
  ProfileData({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final dynamic profileImage; // Can be a string (URL), or null
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      profileImage: json["profile_image"], // Dynamic, can be string (URL) or null
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
