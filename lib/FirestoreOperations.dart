

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentor_match/UserModel.dart';

dynamic joinGroup(String groupCode, String uid, UserModel user) async {
  try {
    var groupRef = await FirebaseFirestore.instance.collection("groups").doc(groupCode).get(); 
    // var memberRef = await FirebaseFirestore.instance.collection("groups").doc(groupCode).collection("members").doc(uid).get(); 
    if (groupRef.exists) {
        await FirebaseFirestore.instance.collection("groups").doc(groupCode).collection("members").doc(uid).set({'uid': uid, 'role': "student", "name": user.name, "grade": user.grade, "email": user.email});
        await FirebaseFirestore.instance.collection("users").doc(uid).update({"groupID": groupRef.data()!["group_id"]});
        // await FirebaseFirestore.instance.collection("users").doc(uid).update({"groups": FieldValue.arrayUnion([groupCode])}); 
    } else {
      return "Invalid code"; 
    }
  } catch (e) { 
    return e.toString(); 
  }
}

dynamic editProfile (String newName, String newGrade, String uid, String groupID) async {
  try {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({"name" : newName, "grade": newGrade});

    await FirebaseFirestore.instance.collection("groups").doc(groupID).collection("members").doc(uid).update({"name": newName, "grade": newGrade});
  } catch(e) {
    return "Unable to update profile"; 
  }
}

dynamic submitTutorRequest(String submitterUID, String submitterName, List availability, String subject, String description, String groupID, String userEmail) async {
  try {
    // DocumentReference groupSessionReference = await FirebaseFirestore.instance.collection("groups").doc(groupID).collection("tutor_requests").add({"submitterID": submitterUID, "submitterName": submitterName, "submitterAvailability": availability, "subject": subject, "description": description, "submitterEmail" : userEmail, "pending": "true", "groupID": groupID});
    // await groupSessionReference.update({"groupSessionReference" : groupSessionReference.id});
    // DocumentReference userSessionReference = await FirebaseFirestore.instance.collection("users").doc(submitterUID).collection("pending_requests").add({"submitterID": submitterUID, "submitterName": submitterName, "submitterAvailability": availability, "subject": subject, "description": description, "submitterEmail" : userEmail, "pending": "true", "groupID": groupID, "groupSessionReference": groupSessionReference.id});
    // await groupSessionReference.update({"userSessionReference": userSessionReference.id}); 

    await FirebaseFirestore.instance.collection("groups").doc(groupID).collection("tutor_requests").add({"submitterID": submitterUID, "submitterName": submitterName, "submitterAvailability": availability, "subject": subject, "description": description, "submitterEmail" : userEmail, "pending": "true", "groupID": groupID});
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