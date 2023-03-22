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
      path: '/home/:userId', //có params phải làm thế này!
      name: '/home',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return HomeScreen(
          userId: state.params['userId'],
        );
      },
    ),
    GoRoute(
      path: '/changepass',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        String userEmail = state.extra as String; // dùng extra có khi xịn hơn
        return ChangePasswordScreen(userEmail: userEmail);
      },
    ),
    GoRoute(
      path: '/addnote',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return AddNoteScreen();
      },
    ),
    GoRoute(
        path: '/detail',
        name: '/detail',
        builder: (context, state) {
          GLOBAL_CONTEXT = context;
          Note note = state.extra as Note;
          return DetailScreen(note: note);
        }),
    GoRoute(
        path: '/updatenote',
        name: '/updatenote',
        builder: (context, state) {
          GLOBAL_CONTEXT = context;
          Note note = state.extra as Note;
          return UpdateNoteScreen(note: note);
        }),
    GoRoute(
      path: '/forgetpass',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return ForgotPasswordScreen();
      },
    ),
    GoRoute(
      path: '/changeuserinfo/:userName/:userDescription', //có params phải làm thế này!
      name: '/changeuserinfo',
      builder: (context, state) {
        GLOBAL_CONTEXT = context;
        return ChangeUserInfoScreen(
          userName: state.params['userName'],
          userDescription: state.params['userDescription'],
        );
      },
    ),
    GoRoute(path: '/search',
    name: '/search',
    builder: (context, state) {
      GLOBAL_CONTEXT = context;
      return SearchScreen();
    },),
  ],
);
