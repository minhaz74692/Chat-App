import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    checkSignIn();
    checkGuestUser();
  }

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  String? _userName;
  String? get name => _userName;

  String? _phone;
  String? get phone => _phone;

  String? _email;
  String? get email => _email;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  Future saveUserData(UserModel userModel, String provider) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('user_name', userModel.userName!);
    await sp.setString('email', userModel.emailId!);
    await sp.setString('sign_in_provider', provider);
    _userName = userModel.userName;
    _email = userModel.emailId;
    _phone = userModel.phone;
    _signInProvider = provider;
    notifyListeners();
  }

  Future saveUserInformation(UserModel userModel) async {
    _userName = userModel.userName;
    _email = userModel.emailId;
    _phone = userModel.phone;
    notifyListeners();
  }

  Future getUserData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _userName = sp.getString('user_name');
    _email = sp.getString('email');
    _signInProvider = sp.getString('sign_in_provider') ?? 'email';
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
  }

  Future userSignout() async {
    // await _socialUserSignOut();
    await clearAllUserData().then((value) async {
      // await BookmarkService().clearBookmarkList();
      _isSignedIn = false;
      _guestUser = false;
      _userName = null;
      _email = null;
      _signInProvider = null;
      notifyListeners();
    });
  }

  _socialUserSignOut() async {
    if (_signInProvider != null && _signInProvider == 'google') {
      // await AuthService.googleSignIn.signOut();
    } else if (_signInProvider == 'fb') {
      // await AuthService.facebookAuth.logOut();
    }
  }

  Future loginAsGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', true);
    _guestUser = true;
    notifyListeners();
  }

  void checkGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _guestUser = sp.getBool('guest_user') ?? false;
    notifyListeners();
  }

  Future clearAllUserData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future guestUserSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
  }
}
