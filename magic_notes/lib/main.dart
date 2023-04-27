import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/utils/constants.dart';
import 'package:magic_notes/utils/style.dart';
import 'package:magic_notes/views/navigation/nav_graph.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  if (kIsWeb) {
    runApp(ProviderScope(child: MyApp()));
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      minimumSize: Size(600, 780),
      center: true,
      title: "Magic Notes",
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    runApp(ProviderScope(child: MyAppWindows()));
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.orange, //Màu thanh status bar
          systemNavigationBarColor: Colors.orange //màu thanh 3 nút bên dưới
          ),
    );
    runApp(ProviderScope(child: MyApp()));
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'NotoSerif',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyAppWindows extends StatefulWidget {
  MyAppWindows({Key? key}) : super(key: key);

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
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
        context: GLOBAL_CONTEXT!,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.orangeAccent.shade200,
            content: Text('Bạn muốn thoát ứng dụng?'),
            actions: [
              TextButton(
                child: Text(
                  "Không",
                  style: textHeadline1,
                ),
                onPressed: () {
                  Navigator.of(GLOBAL_CONTEXT!).pop();
                },
              ),
              TextButton(
                child: Text(
                  "Đúng",
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
