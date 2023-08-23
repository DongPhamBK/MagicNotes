class User {
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userDescription;

  User({
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userDescription,
  });

  User.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPassword = json['userPassword'];
    userDescription = json['userDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPassword'] = userPassword;
    data['userDescription'] = userDescription;
    return data;
  }

  Map<String, dynamic> toJsonLogin() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userEmail'] = userEmail;
    data['userPassword'] = userPassword;
    return data;
  }

  @override
  String toString() {
    return 'User{userName: $userName, userEmail: $userEmail, userPassword: $userPassword, userDescription: $userDescription}';
  }
}
