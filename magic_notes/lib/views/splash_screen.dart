import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/utils/style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(
            const Duration(seconds: 0),
            //Chờ thứ nhất
            () {
              return;
            },
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text("Configuring Device..."),
                ],
              );
            }
            return FutureBuilder(
              future: Future.delayed(
                const Duration(seconds: 1),
                () {
                  context.go('/login');
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/app_icon.png'),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "MAGICNOTES",
                        style: textHeadline1.copyWith(
                          color: Colors.deepOrange,
                          fontSize: 36,
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
