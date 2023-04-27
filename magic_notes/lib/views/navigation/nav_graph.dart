import 'package:go_router/go_router.dart';
import 'package:magic_notes/models/note.dart';
import 'package:magic_notes/views/add_note_screen.dart';
import 'package:magic_notes/views/change_password_screen.dart';
import 'package:magic_notes/views/change_user_info_screen.dart';
import 'package:magic_notes/views/forgot_password_screen.dart';
import 'package:magic_notes/views/search_screen.dart';
import 'package:magic_notes/views/signup_screen.dart';
import 'package:magic_notes/views/update_note_screen.dart';

import '../../utils/constants.dart';
import '../detail_screen.dart';
import '../home_screen.dart';
import '../login_screen.dart';
import '../splash_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/', //bắt buộc có một path mặc định thế này
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return LoginScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return SignUpScreen();
      },
    ),
    GoRoute(
      path: '/home', //Cập nhật extra tránh công khai userId
      name: '/home',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        String userId = state.extra as String;
        return HomeScreen(userId: userId);
      },
      redirect: (context, state) => auth(), //Đăng nhập đồng nghĩa với tồn tại USER_ID, xác thực
    ),
    GoRoute(
      path: '/changepass',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        String userEmail = state.extra as String; // dùng extra có khi xịn hơn
        return ChangePasswordScreen(userEmail: userEmail);
      },
      redirect: (context, state) => auth(), //Đăng nhập đồng nghĩa với tồn tại USER_ID, xác thực
    ),
    GoRoute(
      path: '/addnote',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return AddNoteScreen();
      },
      redirect: (context, state) => auth(), //Đăng nhập đồng nghĩa với tồn tại USER_ID, xác thực
    ),
    GoRoute(
      path: '/detail',
      name: '/detail',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        Note note = state.extra as Note;
        return DetailScreen(note: note);
      },
      redirect: (context, state) => auth(), //Đăng nhập đồng nghĩa với tồn tại USER_ID, xác thực
    ),
    GoRoute(
      path: '/updatenote',
      name: '/updatenote',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        Note note = state.extra as Note;
        return UpdateNoteScreen(note: note);
      },
      redirect: (context, state) => auth(), //Đăng nhập đồng nghĩa với tồn tại USER_ID, xác thực
    ),
    GoRoute(
      path: '/forgetpass',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return ForgotPasswordScreen();
      },
    ),
    GoRoute(
      path: '/changeuserinfo', //có params phải làm thế này!
      name: '/changeuserinfo',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        Map map = state.extra as Map;
        return ChangeUserInfoScreen(
          userName: map['userName'],
          userDescription: map['userDescription'],
        );
      },
      redirect: (context, state) => auth(), //Đăng nhập đồng nghĩa với tồn tại USER_ID, xác thực
    ),
    GoRoute(
      path: '/search',
      name: '/search',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return SearchScreen();
      },
      redirect: (context, state) => auth(), //Đăng nhập đồng nghĩa với tồn tại USER_ID, xác thực
    ),
  ],
  errorBuilder: (context, state) => LoginScreen(), //Nếu điều hướng lỗi, về trang khởi tạo!
);

String? auth() => USER_ID == "" ? '/login' : null;
