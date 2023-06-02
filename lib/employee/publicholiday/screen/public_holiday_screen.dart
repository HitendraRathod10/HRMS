import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_attendance_app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
//ignore: must_be_immutable
class PublicHolidayScreen extends StatelessWidget {
  PublicHolidayScreen({Key? key}) : super(key: key);

  var pubilcHolidayDetails = FirebaseFirestore.instance.collection("holiday").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: const Text('Public Holiday',style: TextStyle(fontFamily: AppFonts.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: StreamBuilder(
            stream: pubilcHolidayDetails,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> streamSnapshot)  {
                if(streamSnapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                } if (streamSnapshot.hasError) {
                  return const Center(child: Text("Something went wrong",style: TextStyle(fontFamily: AppFonts.regular)));
                } else if (streamSnapshot.connectionState == ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (streamSnapshot.requireData.docChanges.isEmpty){
                  return const Center(child: Text("Data does not exist",style: TextStyle(fontFamily: AppFonts.regular)));
                } else{
                  return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context,index) {
                        return Card(
                          color: AppColor.whiteColor,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Text('${index+1}',style: const TextStyle(fontFamily: AppFonts.medium),),
                                  trailing: Text('${streamSnapshot.data?.docs[index]['holidayDate']}',style: const TextStyle(fontFamily: AppFonts.medium),),
                                  title:Text('${streamSnapshot.data?.docs[index]['holidayName']}',
                                      style: const TextStyle(fontSize: 16,fontFamily: AppFonts.medium,overflow: TextOverflow.ellipsis)
                                      ,maxLines: 1,
                                  ),
                                  subtitle:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${streamSnapshot.data?.docs[index]['holidayDescription']}',
                                          style: const TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis,fontFamily: AppFonts.medium)
                                        ,maxLines: 2),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
            }
          ),
        ),
      ),
    );
  }
}
