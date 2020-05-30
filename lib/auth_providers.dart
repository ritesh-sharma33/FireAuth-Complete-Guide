import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProviders {

  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  Future<String> handleGoogleSignIn() async {

    try {
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken, 
        accessToken: googleSignInAuthentication.accessToken
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      if (user.isAnonymous) {
        print("The user is anonymous");
        return null;
      }

      if (await user.getIdToken() == null) {
        print("Invalid token ID");
        return null;
      }

      final FirebaseUser currentFireUser = await _auth.currentUser();
      if (user.uid != currentFireUser.uid) {
        print("Invalid user");
        return null;
      }

      return user.email.toString();


    } catch(e) {
      print(e);
      return null;
    }

  }
}
