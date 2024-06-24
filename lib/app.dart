import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/tab_controller_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/screens/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthProvider>(
            create: (context) => FirebaseAuthProvider()),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<TabControllerProvider>(
            create: (context) => TabControllerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
