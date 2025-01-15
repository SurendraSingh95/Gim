class GetVideoPlanModel {
  GetVideoPlanModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<VideoPlanList> data;

  factory GetVideoPlanModel.fromJson(Map<String, dynamic> json){
    return GetVideoPlanModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<VideoPlanList>.from(json["data"]!.map((x) => VideoPlanList.fromJson(x))),
    );
  }

}

class VideoPlanList {
  VideoPlanList({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.planType,
    required this.trainerId,
    required this.planName,
    required this.planAmount,
    required this.lang,
    required this.image,
    required this.isPlanPurchased,
  });

  final int? id;
  final int? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? planType;
  final int? trainerId;
  final String? planName;
  final String? planAmount;
  final String? lang;
  final String? image;
  final bool? isPlanPurchased;

  factory VideoPlanList.fromJson(Map<String, dynamic> json){
    return VideoPlanList(
      id: json["id"],
      categoryId: json["category_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      planType: json["plan_type"],
      trainerId: json["trainer_id"],
      planName: json["plan_name"],
      planAmount: json["plan_amount"],
      lang: json["lang"],
      image: json["image"],
      isPlanPurchased: json["is_plan_purchased"],
    );
  }

}
