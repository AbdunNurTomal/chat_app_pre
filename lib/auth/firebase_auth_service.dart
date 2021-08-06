import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<String?> loginUser(String email, String pass) async{
    final result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return result.user!.uid;
  }

  static Future<String?> registerUser(String email, String pass) async{
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    return result.user!.uid;
  }
}