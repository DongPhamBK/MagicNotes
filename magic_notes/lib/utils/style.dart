import 'dart:io';

import 'package:flutter/material.dart';

TextStyle textHeadline1 = TextStyle(
  color: Colors.white,
  fontSize: Platform.isWindows ? 20 : 18,
  fontWeight: FontWeight.bold,
);

TextStyle textContent = TextStyle(
  color: Colors.black,
  fontSize: Platform.isWindows ? 18 : 14,
  fontFamily: 'NotoSerif',
);
