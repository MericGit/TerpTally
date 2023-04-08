import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  Future<UserCredential> signInWithGoogle() async {
// Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

// Once signed in, check if the user exists
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

// Check if the user is new
    final bool isNewUser =
        userCredential.additionalUserInfo?.isNewUser ?? false;
    if (isNewUser) {
      // Create new document in the Users collection
      final userDoc =
          FirebaseFirestore.instance.collection('Users').doc(user?.email);
      await userDoc.set({
        'Age': null,
        'CateTransactions': {},
        'Ethnicity': null,
        'Gender': null,
        'Income': null,
        'IndvTransactions': [],
        'Location': null,
        'Name': null,
        'timespan': null
      });
    }
    return userCredential;
  }
}
