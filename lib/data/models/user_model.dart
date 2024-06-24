class UserModel {
  String? userId;
  String? userName;
  String? emailId;
  String? phone;

  UserModel({
    this.userId,
    required this.userName,
    required this.emailId,
    required this.phone,
  });

  UserModel.fromFirestore(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    emailId = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['email'] = emailId;
    data['phone'] = phone;
    return data;
  }
}
