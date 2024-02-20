import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance_app/admin/addemployee/add_employee.dart';
import 'package:employee_attendance_app/admin/addholiday/screen/add_holiday_screen.dart';
import 'package:employee_attendance_app/admin/employeeprofile/employee_details_screen.dart';
import 'package:employee_attendance_app/employee/home/widget/dashboard_details_widget.dart';
import 'package:employee_attendance_app/utils/app_colors.dart';
import 'package:employee_attendance_app/utils/app_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../employee/publicholiday/screen/public_holiday_screen.dart';
import '../../../firebase/firebase_collection.dart';
import '../../leavestatus/leave_status_screen.dart';
import '../../viewemployee/view_registered_employee_screen.dart';
//ignore: must_be_immutable
class AdminHomeScreen extends StatelessWidget {

  AdminHomeScreen({Key? key}) : super(key: key);

  DateTime now = DateTime.now();
  var hour = DateTime.now().hour;
  String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(now.year, now.month, now.day);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.appColor,AppColor.whiteColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //endDrawer:const AdminDrawerScreen(),
        extendBodyBehindAppBar: true,
        body: StreamBuilder(
            stream: FirebaseCollection().adminCollection.doc(FirebaseAuth.instance.currentUser?.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
              if (snapshot.hasError) {
                debugPrint('Something went wrong');
                return const Text("Something went wrong",style: TextStyle(fontFamily: AppFonts.medium),);
              }
              else if (!snapshot.hasData || !snapshot.data!.exists) {
                debugPrint('Document does not exist');
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.requireData.exists){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 50,bottom: 15),
                    child: Row(
                      children: [
                        ClipOval(
                            child: Container(
                                color: AppColor.whiteColor,
                                height: 70,
                                width: 70,
                                child: Center(child: Text('${data['companyName']?.substring(0,1).toUpperCase()}',
                                    style: const TextStyle(
                                        color: AppColor.appColor,
                                        fontSize: 30,
                                        fontFamily: AppFonts.regular))))
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hii, ${capitalizeAllWord(data['companyName'])}',style: const TextStyle(fontFamily: AppFonts.medium,color: AppColor.whiteColor),),
                            const SizedBox(height: 3),
                            Text(hour < 12 ? 'Good Morning' :
                            hour < 17 ? 'Good Afternoon' : 'Good Evening',style: const TextStyle(fontFamily: AppFonts.bold,fontSize: 24,color: AppColor.whiteColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 12),
                      decoration: const BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60))
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Container(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(date.toString().replaceAll("00:00:00.000", ""),style: const TextStyle(fontSize: 20,color: AppColor.appColor,fontFamily: AppFonts.medium))),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const AddHolidayScreen(),
                                          transition: Transition.rightToLeftWithFade);
                                    },
                                    child: dashboardDetailsWidget('https://cdn-icons-png.flaticon.com/512/3199/3199837.png',
                                        'Add Holiday','Add public holiday only',AppColor.appColor.withOpacity(0.4)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const AddEmployee(),
                                          transition: Transition.rightToLeftWithFade);
                                    },
                                    child: dashboardDetailsWidget('https://cdn-icons-png.flaticon.com/512/5065/5065115.png',
                                        'Add Employee','Create an account employee',AppColor.appColor.withOpacity(0.4)),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(EmployeeDetailsScreen(),
                                          transition: Transition.rightToLeftWithFade);
                                    },
                                    child: dashboardDetailsWidget('https://cdn-icons-png.flaticon.com/512/7445/7445626.png',
                                        'Employee Details','List of registered employee details',
                                        AppColor.appColor.withOpacity(0.4)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const ViewEmployeeAttendance(),
                                          transition: Transition.rightToLeftWithFade);
                                    },
                                    child: dashboardDetailsWidget('https://cdn-icons-png.flaticon.com/512/1286/1286827.png',
                                        'View Attendance','List of registered employee attendance',
                                        AppColor.appColor.withOpacity(0.4)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const LeaveStatusScreen(),
                                          transition: Transition.rightToLeftWithFade);
                                    },
                                    child: dashboardDetailsWidget('https://cdn-icons-png.flaticon.com/512/198/198141.png',
                                        'Leave Status','Check the leave status\napproved and reject the leave',AppColor.appColor.withOpacity(0.4)),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(PublicHolidayScreen(),
                                          transition: Transition.rightToLeftWithFade);
                                    },
                                    child: dashboardDetailsWidget('https://cdn-icons-png.flaticon.com/512/3634/3634857.png', 'View Holiday','View the list of public holiday',AppColor.appColor.withOpacity(0.4)),
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],);
              } else if (snapshot.connectionState == ConnectionState.done) {
                return const Center(child: CircularProgressIndicator(),);
              } else{
                return const Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ),
    );
  }
}
extension StringExtension on String {
  String capitalizeText() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
