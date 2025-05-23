import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<User?> signInWithGoogle() async {

    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }
  Future<void> storeUserInHive(User user) async {
    final box = Hive.box<HiveUser>('userBox');
    final hiveUser = HiveUser(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
    );
    await box.put('currentUser', hiveUser);
  }
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}