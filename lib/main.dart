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
