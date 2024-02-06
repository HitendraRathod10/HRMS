import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_utils.dart';

class LeaveFireAuth{

  Future<void> applyLeave(
      {
        required String leaveEmail,
        required String leaveEmployeeName,
        required String leaveFrom,
        required String leaveTo,
        required String leaveDays,
        required String leaveType,
        required String leaveReason,
        required String leaveFromTime,
        required String leaveToTime,
        required String leaveHours,
        required String leaveStatus}) async {
    DocumentReference documentReferencer =
    FirebaseFirestore.instance.collection('leave').doc('$leaveEmail $leaveFrom');

    Map<String, dynamic> data = <String, dynamic>{
      "leaveEmail": leaveEmail.toString(),
      "leaveEmployeeName": leaveEmployeeName.toString(),
      "leaveForm": leaveFrom.toString(),
      "leaveTo": leaveTo.toString(),
      "leaveDays": leaveDays.toString(),
      "leaveStatus": leaveStatus.toString(),
      "leaveFromTime": leaveFromTime.toString(),
      "leaveToTime": leaveToTime.toString(),
      "leaveHours": leaveHours.toString(),
      "leaveReason": leaveReason.toString(),
      "leaveType": leaveType.toString(),
    };
    debugPrint('Leave Application Data => $data');

    await documentReferencer
        .set(data).whenComplete(() {
      debugPrint("Applying for leave");
      AppUtils.instance.showToast(toastMessage: "You have successfully applied leave.");
    }).catchError((e) => debugPrint(e));
  }

}