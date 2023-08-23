import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/models/data_response.dart';
import 'package:magic_notes/models/user.dart';
import 'package:magic_notes/repository/user_repository.dart';
import 'package:magic_notes/utils/constants.dart';

class UserNotifier extends ChangeNotifier {
  late UserRepository userRepository; //Kho
  bool isLoading = false; //Trạng thái đang tải
  DataResponse? dataResponse; //Giá trị phản hồi từ server
  String? logInResult = ""; //Kết quả đăng nhập
  String? signUpResult = ""; //Kết quả đăng ký
  String? changePasswordResult = ""; //Kết quả thay đổi mật khẩu
  User? userInfo; //Thông tin cá nhân
  //Ảnh cá nhân mặc định
  String userPhotoURL = Constants.userPhotoURL;

  UserNotifier({required this.userRepository});

  //Xử lí logIn
  Future<DataResponse?> logIn(User user) async {
    DataResponse? dataResponse;
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.logIn(user);
    logInResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    return dataResponse;
  }

  //Xử lí logIn
  Future<DataResponse?> signUp(User user) async {
    DataResponse? dataResponse;
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.signUp(user);
    signUpResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    return dataResponse;
  }

  // Lấy thông tin người dùng
  getUserInfo(String userId) async {
    dataResponse = await userRepository.getUserInfo(userId);
    userInfo = User.fromJson(dataResponse!.data);
    notifyListeners();
  }

  //Đổi thông tin người dùng
  Future<DataResponse?> changeUserInfo(String userEmail, String userName, String userDescription) async {
    DataResponse? dataResponse;
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.changeUserInfo(userEmail, userName, userDescription);
    isLoading = false;
    notifyListeners();
    //print(dataResponse);
    return dataResponse;
  }

  //Đổi mật khẩu
  Future<DataResponse?> changeUserPassword(String userEmail, String password, String confirmPassword) async {
    DataResponse? dataResponse;
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.changeUserPassword(userEmail, password, confirmPassword);
    //changePasswordResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    //print(dataResponse);
    return dataResponse;
  }

  //Reset mật khẩu
  Future<DataResponse?> forgotUserPassword(String userEmail) async {
    DataResponse? dataResponse;
    isLoading = true;
    notifyListeners();
    dataResponse = await userRepository.forgotUserPassword(userEmail);
    //changePasswordResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    //print(dataResponse);
    return dataResponse;
  }

  //Lấy ảnh đại diện
  getUserPhoto(String userId) async {
    dataResponse = await userRepository.getUserPhoto(userId);
    userPhotoURL = dataResponse!.data;
    notifyListeners();
  }

  //Đổi ảnh đại diện
  changeUserPhoto(String userId, String base64) async {
    dataResponse = await userRepository.changeUserPhoto(userId, base64);
  }
}

final userProvider = ChangeNotifierProvider((ref) {
  UserRepository userRepository = ref.watch(userRepositoryPr);
  return UserNotifier(userRepository: userRepository);
});
