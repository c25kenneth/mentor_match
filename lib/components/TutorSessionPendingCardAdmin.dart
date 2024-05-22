import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentor_match/components/InputInfoFieldMultiLine.dart';
import 'package:mentor_match/components/LockedInputInfoField.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class TutorSessionPendingCardAdmin extends StatefulWidget {

  final List date; 
  final String subject;
  final String description;

  final String groupID; 

  final String submitterName; 
  final String submitterEmail; 

  final String requestID; 

  final String submitterID; 

  const TutorSessionPendingCardAdmin({super.key, required this.date, required this.subject, required this.description, required this.requestID, required this.groupID, required this.submitterID, required this.submitterName, required this.submitterEmail});

  @override
  State<TutorSessionPendingCardAdmin> createState() => _TutorSessionPendingCardAdminState();
}

class _TutorSessionPendingCardAdminState extends State<TutorSessionPendingCardAdmin> {
  String dateString = "";
  static const primaryColor = Color(0xff4338CA);
  static const secondaryColor = Color(0xff6D28D9);
  static const accentColor = Color(0xffffffff);
  static const errorColor = Color(0xffEF4444);

  String currentSelectedValue = "";
  String currentSelectedDate = "";

  final MultiSelectController _multiSelectControllerTutor = MultiSelectController();
  final MultiSelectController _multiSelectControllerDate = MultiSelectController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.date.forEach((element) {
      dateString += element += ", ";
    });

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; 
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("members").snapshots(),
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(15),
          child: Card(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(14, 14, 14, 1),
                  child: ListTile(
                    title: Wrap(
                      children: [
                        Text(widget.subject, style: TextStyle(color: Colors.black, fontSize: 21), maxLines: 1, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                    subtitle: Wrap(
                      children: [
                        Text(widget.submitterName, style: TextStyle(color: Colors.black87,), maxLines: 1, overflow: TextOverflow.ellipsis,),
                        Text(widget.submitterEmail, style: TextStyle(color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis,),
                        
                      ],
                    ),
                    trailing: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 5,
                      children: [
                        IconButton(
                          tooltip: "Approve",
                          icon: Icon(Icons.check, color: Colors.green,), onPressed: () async {
                          showModalBottomSheet(context: context, isScrollControlled: true, builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.85,
                                  child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 32, 0, 5),
                                        child: Text(
                                          widget.subject, 
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold, 
                                            fontSize: 28,
                                          ),
                                        )),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                                        child: Text(
                                          widget.description, 
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400, 
                                            fontSize: 16,
                                          ),
                                        )),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.85,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tutee",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black.withOpacity(.9)),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              height: 50,
                                              decoration: BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(12, 26),
                                                    blurRadius: 50,
                                                    spreadRadius: 0,
                                                    color: Colors.grey.withOpacity(.1)),
                                              ]),
                                              child: TextFormField(
                                                initialValue: widget.submitterName + " (" + widget.submitterEmail + ")",
                                                readOnly: true,
                                                style: const TextStyle(fontSize: 14, color: Colors.black),
                                                decoration: InputDecoration(
                                                  // prefixIcon: Icon(Icons.email),
                                                  filled: true,
                                                  fillColor: accentColor,
                                                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                                                  border: const OutlineInputBorder(
                                                    borderSide: BorderSide(color: primaryColor, width: 1.0),
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  ),
                                                  focusedBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide(color: secondaryColor, width: 1.0),
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  ),
                                                 errorBorder:const OutlineInputBorder(
                                                    borderSide: BorderSide(color: errorColor, width: 1.0),
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  ) ,
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide(color: primaryColor, width: 1.0),
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                                SizedBox(height: 20), 
                                                Text("Select Tutor"), 
                                                SizedBox(height: 8), 
                                                Container(
                                                  // width: width * 0.8,
                                                  child: MultiSelectDropDown(
                                                    borderColor: Color(0xff4338CA),
                                                     borderWidth: 1,
                                                    searchEnabled: true,
                                                    searchLabel: "Search",
                                                    hint: "Select Tutor",
                                                    controller: _multiSelectControllerTutor,
                                                    onOptionSelected: (List<ValueItem> selectedOptions) {},
                                                    options: (snapshot.data!.docs as List<DocumentSnapshot>).map((DocumentSnapshot doc) {
                                                      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
                                                      return ValueItem(label: data!["name"], value: data["uid"]);
                                                    }).toList(),
                                                    selectionType: SelectionType.single,
                                                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                                                    dropdownHeight: 300,
                                                    optionTextStyle: const TextStyle(fontSize: 16),
                                                    selectedOptionIcon: const Icon(Icons.check_circle),
                                                  ),
                                                ),
                                                // Container(
                                                //       decoration: BoxDecoration(
                                                //         borderRadius: BorderRadius.circular(15),
                                                //         color: Colors.white,
                                                //       ),
                                                //       width: MediaQuery.of(context).size.width * 0.8,
                                                //       child: InputDecorator(
                                                //         decoration: InputDecoration(
                                                //             border: OutlineInputBorder(
                                                //         borderRadius: BorderRadius.circular(15.0))),
                                                //         child: DropdownButtonHideUnderline(
                                                //           child: DropdownButton(
                                                //             hint: Text("Select Tutee"),
                                                //             value: (currentSelectedValue == "" ? snapshot.data!.docs[0]["uid"] : currentSelectedValue),
                                                //             isDense: true,
                                                //             onChanged: (newValue) {
                                                //               setState(() {
                                                //                 currentSelectedValue = newValue.toString(); 
                                                //               });
                                                //             },  
                                                //             items: snapshot.data!.docs.map((DocumentSnapshot doc) {
                                                //               Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
                                                //               return DropdownMenuItem<String>(
                                                //                 value: data?["uid"],
                                                //                 child: Text(data?["name"]),
                                                //               );
                                                //             }).toList(),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //           ),
                                                      SizedBox(height: 20), 
                                                Text("Select Date"), 
                                                SizedBox(height: 8), 
                                                Container(
                                                  // width: width * 0.8,
                                                  child: MultiSelectDropDown(
                                                    borderColor: Color(0xff4338CA),
                                                     borderWidth: 1,
                                                    searchEnabled: true,
                                                    searchLabel: "Search",
                                                    hint: "Select Time",
                                                    controller: _multiSelectControllerDate,
                                                    onOptionSelected: (List<ValueItem> selectedOptions) {},
                                                    options: (widget.date).map((dynamic date) {
                                                      return ValueItem(label: date, value: date);
                                                    }).toList(),
                                                    selectionType: SelectionType.single,
                                                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                                                    dropdownHeight: 300,
                                                    optionTextStyle: const TextStyle(fontSize: 16),
                                                    selectedOptionIcon: const Icon(Icons.check_circle),
                                                  ),
                                                ),
                                            // Container(
                                            //       decoration: BoxDecoration(
                                            //         borderRadius: BorderRadius.circular(15),
                                            //         color: Colors.white,
                                            //       ),
                                            //       width: MediaQuery.of(context).size.width * 0.8,
                                            //       child: InputDecorator(
                                            //         decoration: InputDecoration(
                                            //             border: OutlineInputBorder(
                                            //         borderRadius: BorderRadius.circular(15.0))),
                                            //         child: DropdownButtonHideUnderline(
                                            //           child: DropdownButton(
                                            //             hint: Text("Select Date"),
                                            //             value: (currentSelectedDate == "" ? widget.date[0] : currentSelectedDate),
                                            //             isDense: true,
                                            //             onChanged: (newValue) {
                                            //               setState(() {
                                            //                 currentSelectedDate = newValue.toString(); 
                                            //               });
                                            //             },  
                                            //             items: widget.date.map((dynamic date) {
                                            //               return DropdownMenuItem<String>(
                                            //                 value: date,
                                            //                 child: Text(date),
                                            //               );
                                            //             }).toList(),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //           ),
                                                      SizedBox(height: 16,),
                                                      Container(width: width * 0.85, child: InfoInputFieldMultiLineFb1(inputController: _descriptionController, title: "Additional Info", description: widget.description)),
                                                      SizedBox(height: 32),
                                                  Container(
                                                    width: width * 0.85,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        if (_multiSelectControllerTutor.selectedOptions.length != 0 && _multiSelectControllerDate.selectedOptions.length != 0) {
                                                          await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                            DocumentSnapshot tutorSnapshot = await myTransaction.get(FirebaseFirestore.instance.collection("users").doc(_multiSelectControllerTutor.selectedOptions[0].value));
                                                            await myTransaction.update(FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("tutor_requests").doc(widget.requestID), {"description": _descriptionController.text == "" ? widget.description : _descriptionController.text, "pending": "false", "submitterAvailability": _multiSelectControllerDate.selectedOptions[0].value, "tutorID": _multiSelectControllerTutor.selectedOptions[0].value, "tutorName": tutorSnapshot["name"]});
                                                          });
                                                          Navigator.of(context).pop(); 
                                                        } else {
                                                          print("Empty");
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        foregroundColor: Color.fromRGBO(186,38,255, 0.8),
                                                        backgroundColor: Color.fromRGBO(186,38,255, 0.8),
                                                        shape: RoundedRectangleBorder(
                                                            // Change your radius here
                                                            borderRadius: BorderRadius.circular(12),
                                                        ),
                                                      ),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                                        child: Text("Schedule Session", style: TextStyle(color: Colors.white,)),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                                                ),
                                );
                              },
                            ); 
                          });
                        },),
                        IconButton(
                          tooltip: "Deny",
                          icon: Icon(Icons.close, color: Colors.red), onPressed: () async {
                          try {
                            await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                await myTransaction.delete(FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("tutor_requests").doc(widget.requestID));
                                // await myTransaction.delete(FirebaseFirestore.instance.collection("users").doc(widget.submitterID).collection("pending_requests").doc(widget.requestIdUser));
                            });
                            print("success");
                          } catch (e) {
                            print("Error");
                          }
                        },),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(14),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.calendar_month_outlined, color: Color.fromRGBO(163, 124, 240, 0.9),),
                      SizedBox(width: 10),
                      Expanded(child: Text(dateString.substring(0, dateString.length - 2), style: TextStyle(color: Color.fromRGBO(163, 124, 240, 0.9)), maxLines: 1, overflow: TextOverflow.ellipsis,))
                    ],
                  ),
                ),
              ],
            ),
          )
        );
      }
    );
  }
}