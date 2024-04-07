

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentor_match/UserModel.dart';

dynamic joinGroup(String groupCode, String uid, UserModel user) async {
  try {
    var groupRef = await FirebaseFirestore.instance.collection("groups").doc(groupCode).get(); 
    var memberRef = await FirebaseFirestore.instance.collection("groups").doc(groupCode).collection("members").doc(uid).get(); 
    if (groupRef.exists) {
      if (memberRef.exists == false) {
        await FirebaseFirestore.instance.collection("groups").doc(groupCode).collection("members").doc(uid).set({'uid': uid, 'role': "student", "name": user.name, "grade": user.grade, "email": user.email});
        await FirebaseFirestore.instance.collection("users").doc(uid).collection("groups").doc(groupCode).set(groupRef.data()!);
        await FirebaseFirestore.instance.collection("users").doc(uid).update({"groups": FieldValue.arrayUnion([groupCode])}); 
      } else {
        return "You are already in this group!"; 
      }
    } else {
      return "Invalid code"; 
    }
  } catch (e) { 
    return e.toString(); 
  }
}

dynamic editProfile (String newName, String newGrade, String uid) async {
  try {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({"name" : newName, "grade": newGrade});
    dynamic groupList = await FirebaseFirestore.instance.collection("users").doc(uid).get(); 

    groupList["groups"].forEach((element) async {
      await FirebaseFirestore.instance.collection("groups").doc(element).collection("members").doc(uid).update({"name": newName, "grade": newGrade});
    });
  } catch(e) {
    return "Unable to update profile"; 
  }
}

dynamic submitTutorRequest(String submitterUID, String submitterName, List availability, String subject, String description, String groupID, String userEmail) async {
  try {
    await FirebaseFirestore.instance.collection("groups").doc(groupID).collection("tutor_requests").doc().set({"submitterID": submitterUID, "submitterName": submitterName, "submitterAvailability": availability, "subject": subject, "description": description, "submitterEmail" : userEmail, "pending": "true"});
    await FirebaseFirestore.instance.collection("groups").doc(submitterUID).collection("pending_requests").doc().set({"submitterID": submitterUID, "submitterName": submitterName, "submitterAvailability": availability, "subject": subject, "description": description, "submitterEmail" : userEmail, "pending": "true"});
  } catch(e) {
    return "Unable to process request"; 
  }
} 

dynamic doesProfileExist(String uid) async {
  try {
    var userRef = await FirebaseFirestore.instance.collection("users").doc(uid).get(); 
    if (userRef.exists) {
      return true; 
    } else {
      return false; 
    }
  } catch (e) {
    return "Error fetching user data";
  }
}