import 'dart:async';

import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:juna_bhajan/data/model/exception.dart';
import 'package:juna_bhajan/data/model/user.dart';
import 'package:juna_bhajan/data/repository/local_repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepository {
  final status = BehaviorSubject<UserData?>.seeded(null);
  final LocalRepository localRepository;
  late StreamSubscription authStatesSubscription;

  AuthRepository({
    required this.localRepository,
  }) {
    authStatesSubscription = _getAuthStatus().listen((event) {
      if (event != null) {
        status.add(UserData.fromFirebaseUse(event));
      } else {
        status.add(null);
      }
    });
  }

  Stream<User?> _getAuthStatus() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      localRepository.deleteFavoriteList();
    } catch (e, str) {
      Fimber.e("SettingBloc SignOut", ex: e, stacktrace: str);
    }
  }

  Future<UserData> login() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn().catchError((e) {
      if (e is PlatformException) {
        throw NetworkException(message: e.message.toString());
      } else {
        throw NetworkException(message: e.toString());
      }
    });
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return UserData.fromFirebaseUse(userCredential.user!);
    } else {
      throw NetworkException(message: "It seems you've canceled login");
    }
  }

  void dispose() {
    authStatesSubscription.cancel();
    status.close();
  }
}
