import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/menu_list_items.dart';

class DisasterList extends StatelessWidget {
  DisasterList({super.key});

  final DisastersListController disasterController = Get.put( DisastersListController() );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: 
      Obx((){
        if( disasterController.isLoading.value ) {
          return const Center(
            child: CircularProgressIndicator(), 
          );
        }
 
        // print( "here ${disasterController.disasters.length}" );

        return SingleChildScrollView(
          child: Container( 
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text( 'Disasters', style: TextStyle( fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold ), ),
                const SizedBox( height: 10 ),
                const MenuListItems( first_title: "Active Disasters", second_title: "Preparedness", ),
                 ListView.builder( 
                  itemCount: disasterController.disasters.length,
                  itemBuilder: ( context, index ) {
                    return const Text( "Test 1 2 3..." );
                  },
                 ),
                // SizedBox( height: 10 ),
                // DisasterListItem(title: 'Floods', location: "Kasese", subtitle: 'Heavy rainfall has caused severe flooding resulting, in widespread destruction', date: '15th Nov 2024' ),
                // SizedBox(height: 10),
                // DisasterListItem(title: 'Chorela', location: "Masindi", subtitle: 'Heavy rainfall has caused severe flooding resulting, in widespread destruction', date: '16th Nov 2024')
              ],
            ),
          ),
        );
      })
    );
  }
}