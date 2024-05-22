import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart'; 

// dynamic registerUser(String emailAddress, String password, String name, String grade) async {
//   try {
//   UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: emailAddress,
//     password: password,
//   );

//   addStudentInfo(cred.user!.uid, name,  password); 
//   return cred.user!.uid;
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//     print('The password provided is too weak.');
//     return e; 
//   } else if (e.code == 'email-already-in-use') {
//     print('The account already exists for that email.');
//     return e; 
//   }
// } catch (e) {
//   print(e);
//   return e; 
// }
// }
dynamic signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
      return "Error Signing In. Please Try Again Later";
    }
  }
  
dynamic createUserEmailAndPassword(String email, String password) async {
  try {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  } catch (e) {
    return "Error creating new account. Please try again later"; 
  }
}

dynamic signInStudent(String emailAddress, String password) async {
  try {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password); 
  } catch (e) {
    print(e.toString());
    return "Error signing in. Please try again later";
  }
}

// dynamic signInStudent(String emailAddress, String password) async {
//   try {
//     UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password); 
//     return cred.user!.uid; 
//   } catch (e) {
//     print(e.toString());
//     return e;
//   }
// }

dynamic addStudentInfo(String uid, String grade, String email, String name) async {
  try {
    await FirebaseFirestore.instance.collection("users").doc(uid).set({'uid': uid, 'role': "student", "grade": grade, "groupID": "", "email": email, "name": name});
  } catch(e) {
    print(e); 
    return "Error creating account. Please try again"; 
  }
}
