class User {
  User({
    required this.id,
    required this.emailId,
    required this.userName,
    required this.phoneNo,
    required this.userRole,
  });
  late final int id;
  late final String emailId;
  late final String userName;
  late final int phoneNo;
  late final String userRole;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emailId = json['emailId'];
    userName = json['userName'];
    phoneNo = json['phoneNo'];
    userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['emailId'] = emailId;
    data['userName'] = userName;
    data['phoneNo'] = phoneNo;
    data['userRole'] = userRole;
    return data;
  }
}
