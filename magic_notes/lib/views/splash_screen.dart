import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
            //Chờ thứ nhất, config các thứ cơ bản
            () {
              return;
            },
          ),
          builder: (context, snapshot) {
            return FutureBuilder(
              future: Future.delayed(
                const Duration(milliseconds: 1000),
                () {
                  context.go('/login');
                },
              ),
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Animate(
                      child: Image.asset('assets/app_icon.png'),
                      effects: const [
                        ScaleEffect(duration: Duration(milliseconds: 500)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Animate(
                      effects: const [ShimmerEffect(duration: Duration(milliseconds: 650))],
                      child: Text(
                        "MAGICNOTES",
                        style: textHeadline1.copyWith(
                          color: Colors.deepOrange,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Text("Version 1.0"),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
