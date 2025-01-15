class GetPlansModel {
  GetPlansModel({
    required this.success,
    required this.message,
    required this.user,
  });

  final bool? success;
  final String? message;
  final List<UserList> user;

  factory GetPlansModel.fromJson(Map<String, dynamic> json){
    return GetPlansModel(
      success: json["success"],
      message: json["message"],
      user: json["user"] == null ? [] : List<UserList>.from(json["user"]!.map((x) => UserList.fromJson(x))),
    );
  }

}

class UserList {
  UserList({
    required this.id,
    required this.userId,
    required this.membershipPlanId,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionId,
  });

  final int? id;
  final int? userId;
  final int? membershipPlanId;
  final String? amount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? transactionId;

  factory UserList.fromJson(Map<String, dynamic> json){
    return UserList(
      id: json["id"],
      userId: json["user_id"],
      membershipPlanId: json["membership_plan_id"],
      amount: json["amount"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      transactionId: json["transaction_id"],
    );
  }

}
