// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unnecessary_nullable_for_final_variable_declarations, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/screens/login.dart';

// import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get getAuthChange => _firebaseAuth.authStateChanges();

  // final GoogleSignIn _googlSignIn = new GoogleSignIn();

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _name;
  String? get name => _name;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  String? timestamp;

  String _appVersion = '0.0';
  String get appVersion => _appVersion;

  String _packageName = '';
  String get packageName => _packageName;

  Future signInwithEmailPassword(userEmail, userPassword) async {
    try {
      final User? user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: userEmail, password: userPassword))
          .user!;
      assert(user != null);
      await user!.getIdToken();
      final User currentUser = _firebaseAuth.currentUser!;
      _uid = currentUser.uid;
      _signInProvider = 'email';
      _email = user.email;

      _hasError = false;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
      debugPrint('$e');
      _hasError = true;
      _errorCode = e.toString();
      notifyListeners();
    }
  }

  Future signUpwithEmailPassword(userName, userEmail, userPassword) async {
    try {
      final User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      ))
          .user!;
      assert(user != null);
      await user!.getIdToken();
      _name = userName;
      _uid = user.uid;
      _email = user.email;
      _signInProvider = 'email';

      _hasError = false;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _errorCode = e.toString();
      notifyListeners();
    }
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future signOut(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut().then((value) {
      sp.remove("isSignedIn").then(
        (_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LogIn(),
            ),
          );
        },
      );
    });
    _isSignedIn = false;
    notifyListeners();
  }
}
