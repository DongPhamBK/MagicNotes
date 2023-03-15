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
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['userPassword'] = this.userPassword;
    data['userDescription'] = this.userDescription;
    return data;
  }

  Map<String, dynamic> toJsonLogin() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userEmail'] = this.userEmail;
    data['userPassword'] = this.userPassword;
    return data;
  }

  @override
  String toString() {
    return 'User{userName: $userName, userEmail: $userEmail, userPassword: $userPassword, userDescription: $userDescription}';
  }
}
