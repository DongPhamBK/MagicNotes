import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/utils/constants.dart';
import 'package:magic_notes/utils/style.dart';
import 'package:magic_notes/views/navigation/nav_graph.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Tương tác chỉ dùng cho Windows
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(600, 760));
    WindowOptions windowOptions = const WindowOptions(size: Size(600, 760), title: "Magic Notes", titleBarStyle: TitleBarStyle.normal);
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    runApp(const ProviderScope(child: MyAppWindows()));
  } else {
    runApp(const ProviderScope(child: MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyAppWindows extends StatefulWidget {
  const MyAppWindows({Key? key}) : super(key: key);

  @override
  State<MyAppWindows> createState() => _MyAppWindowsState();
}

class _MyAppWindowsState extends State<MyAppWindows> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    onWindowFocus();
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowFocus() {
    // Make sure to call once.
    setState(() {});
    // do something
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: GLOBAL_CONTEXT!,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.orangeAccent.shade200,
            content: Text('Bạn muốn thoát ứng dụng, bạn sẽ phải đăng nhập lại!'),
            actions: [
              TextButton(
                child: const Text(
                  "Trở lại ứng dụng",
                  style: textHeadline1,
                ),
                onPressed: () {
                  Navigator.of(GLOBAL_CONTEXT!).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Đã hiểu",
                  style: textHeadline1,
                ),
                onPressed: () async {
                  Navigator.of(GLOBAL_CONTEXT!).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("build root");
    GLOBAL_CONTEXT = context;
    //print(GLOBAL_CONTEXT);
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(fontFamily: 'NotoSerif'),
      debugShowCheckedModeBanner: false,
    );
  }
}
