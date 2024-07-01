import 'package:chat_app/app.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Set status bar color
    statusBarIconBrightness:
        Brightness.dark, // For Android, use Brightness.light or Brightness.dark
    statusBarBrightness:
        Brightness.light, // For iOS, use Brightness.light or Brightness.dark
  ));
  runApp(const MyApp());
}

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs



// Copyright 2024 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

// import 'package:chat_app/screens/chat/views/chat_screen.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';

// void main() async {
//   await dotenv.load();
//   runApp(const GenerativeAISample());
// }

// class GenerativeAISample extends StatelessWidget {
//   const GenerativeAISample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter + Generative AI',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           brightness: Brightness.dark,
//           seedColor: const Color.fromARGB(255, 171, 222, 244),
//         ),
//         useMaterial3: true,
//       ),
//       // home: const GeminiChatScreen(title: 'Flutter + Generative AI'),
//       home: ChatScreen(),
//     );
//   }
// }



