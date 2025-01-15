class GetMemberShipPlanModel {
  GetMemberShipPlanModel({
    required this.success,
    required this.data,
  });

  final bool? success;
  final List<PlanData> data;

  factory GetMemberShipPlanModel.fromJson(Map<String, dynamic> json){
    return GetMemberShipPlanModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<PlanData>.from(json["data"]!.map((x) => PlanData.fromJson(x))),
    );
  }

}

class PlanData {
  PlanData({
    required this.id,
    required this.adminId,
    required this.name,
    required this.description,
    required this.isActive,
    required this.price,
    required this.durationInDays,
    required this.createdAt,
    required this.updatedAt,
    required this.startDate,
    required this.endDate,
  });

  final int? id;
  final int? adminId;
  final String? name;
  final String? description;
  final int? isActive;
  final String? price;
  final int? durationInDays;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? startDate;
  final DateTime? endDate;

  factory PlanData.fromJson(Map<String, dynamic> json){
    return PlanData(
      id: json["id"],
      adminId: json["admin_id"],
      name: json["name"],
      description: json["description"],
      isActive: json["is_active"],
      price: json["price"],
      durationInDays: json["duration_in_days"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
    );
  }

}
