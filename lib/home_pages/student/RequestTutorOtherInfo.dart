import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentor_match/FirestoreOperations.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/GradientButton2.dart';
import 'package:mentor_match/components/InputInfoFieldMultiLine.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class RequestTutorOtherInfo extends StatefulWidget {
  final String groupID;
  const RequestTutorOtherInfo({super.key, required this.groupID});

  @override
  State<RequestTutorOtherInfo> createState() => _RequestTutorOtherInfoState();
}

class _RequestTutorOtherInfoState extends State<RequestTutorOtherInfo> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance; 
  TextEditingController _extraInfoController =TextEditingController();
  final MultiSelectController _controllerSubject = MultiSelectController();
  final MultiSelectController _controllerAvailability = MultiSelectController();

  String errorText = ""; 
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; 
    return StreamBuilder(
      stream: _db.collection("users").doc(_auth.currentUser!.uid).collection("groups").doc(widget.groupID).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            stream: _db.collection("users").doc(_auth.currentUser!.uid).snapshots(),
            builder: (context, innerSnapshot) {
              if (innerSnapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                    ),
                  ),
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  screenWidth * 0.8, 20, screenWidth * 0.8, 0),
                              child: Text(
                                snapshot.data!["group_name"],
                                style: TextStyle(
                                  fontSize: 85,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Choose Subject"), 
                              SizedBox(height: 7),
                              Container(
                                width: screenWidth * 0.8,
                                child: MultiSelectDropDown(
                                  controller: _controllerSubject,
                                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                                  options: (snapshot.data!["available_subjects"] as List<dynamic>).map((e) {
                                    return ValueItem(label: e, value: e);
                                  }).toList(),
                                  selectionType: SelectionType.single,
                                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                                  dropdownHeight: 300,
                                  optionTextStyle: const TextStyle(fontSize: 16),
                                  selectedOptionIcon: const Icon(Icons.check_circle),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Select Availability"), 
                              SizedBox(height: 7),
                              Container(
                                width: screenWidth * 0.8,
                                child: MultiSelectDropDown(
                                  controller: _controllerAvailability,
                                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                                  options: (snapshot.data!["times_available"] as List<dynamic>).map((e) {
                                    return ValueItem(label: e, value: e);
                                  }).toList(),
                                  selectionType: SelectionType.multi,
                                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                                  dropdownHeight: 300,
                                  optionTextStyle: const TextStyle(fontSize: 16),
                                  selectedOptionIcon: const Icon(Icons.check_circle),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Additional Info"),
                              Container(width: screenWidth * 0.8,child: InfoInputFieldMultiLineFb1(inputController: _extraInfoController, title: "", description: "")),
                            ],
                          ),
                          SizedBox(height: 15),
                          (errorText == "") ? SizedBox() : Text(errorText, style: TextStyle(color: Colors.red, fontSize: 16),),
                          SizedBox(height: 20),
                          GradientButton2Fb1(text: "Submit Request", onPressed: () async {
                            print(_controllerAvailability.selectedOptions.map((element) {return element.value;}).toList());
                            if (_controllerAvailability.selectedOptions.isEmpty || _controllerSubject.selectedOptions.isEmpty) {
                              setState(() {
                                errorText = "Must choose subject and availability!";
                              });
                            } else {
                              dynamic response = await submitTutorRequest(_auth.currentUser!.uid, innerSnapshot.data!["name"], _controllerAvailability.selectedOptions.map((element) {return element.value;}).toList(), _controllerSubject.selectedOptions[0].value, _extraInfoController.text, widget.groupID, _auth.currentUser!.email.toString());
                              if (response.runtimeType == String) {
                                setState(() {
                                  errorText = response; 
                                });
                              } else {
                                if (context.mounted) Navigator.of(context).pop(); 
                              }
                            }
                          })
                        ],
                      ),
                    ),
                  )
                );
              } else {
                return LoadingScreen(); 
              }
            }
          );
        } else {
          return LoadingScreen();
        }
      }
    );
  }
}