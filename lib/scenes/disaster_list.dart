import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/disaster_list_item.dart';
import 'package:redcross/scenes/menu_list_items.dart';

class DisasterList extends StatelessWidget {
  DisasterList({super.key});

  final DisastersListController disasterController = Get.put( DisastersListController() );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: 
      Obx((){
        if( disasterController.isLoading.value ) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        print( "here ${disasterController.disasters}" );

        return SingleChildScrollView(
          child: Container( 
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( 'Disasters', style: TextStyle( fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold ), ),
                SizedBox( height: 10 ),
                MenuListItems( first_title: "Active Disasters", second_title: "Preparedness", ),
                
                SizedBox( height: 10 ),
                DisasterListItem(title: 'Floods', location: "Kasese", subtitle: 'Heavy rainfall has caused severe flooding resulting, in widespread destruction', date: '15th Nov 2024' ),
                SizedBox(height: 10),
                DisasterListItem(title: 'Chorela', location: "Masindi", subtitle: 'Heavy rainfall has caused severe flooding resulting, in widespread destruction', date: '16th Nov 2024')
              ],
            ),
          ),
        );
      })
    );
  }
}