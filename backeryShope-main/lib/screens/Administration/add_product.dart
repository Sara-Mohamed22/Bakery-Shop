// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mill_10/backend/provider/adminProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AddPrd extends StatefulWidget {

  const AddPrd({Key key,}) : super(key: key);


  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddPrd>{
  File image ;
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  File galleryFile;
  bool permissionGranted;
  imageSelectorGallery() async {
    galleryFile = (await ImagePicker().pickImage(source: ImageSource.gallery,
      // maxHeight: 50.0,
      // maxWidth: 50.0,
    )) as File;
    setState(() {});
  }


  Future getImage() async{
try
   {final image = await ImagePicker().pickImage(source: ImageSource.gallery);
   if (image== null) return;
   final imageTemporary = File(image.path);
   setState(() {
     this.image = imageTemporary ;
   });
   }on PlatformException catch (e){
     print('failed to pick the image: $e');
   }
 }
  


  @override
  Widget build(BuildContext context) {
   
   
    return Scaffold(
      backgroundColor: const Color(0xFF3E2723),
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Add Products',
              style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18.0,
              color: Color(0xFFFFF3E0),
        ),
        ),
        centerTitle: true,
      ),

      
      body:Consumer<AdminProvider>(builder: (context, provider, widget) {

        return  ListView(
          children: [
            Stack(
              children: <Widget>[
                   Container(
                     height: MediaQuery.of(context).size.height - 82,
                     width: MediaQuery.of(context).size.width,
                     color: Colors.transparent,
                   ),
                   Positioned (
                     top: 75.0,
                     child: Container(
                       decoration:const BoxDecoration(
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(45.0),
                           topRight: Radius.circular(45.0)
                         ),
                         color: Color(0xFFFFF3E0),
                       ),
                       height: MediaQuery.of(context).size.height - 100,
                       width: MediaQuery.of(context).size.width,
                     )
                   ),
                    Positioned(
                     top: 80,

                     left: (MediaQuery.of(context).size.width / 2) - 180,
                     child:
                       Padding(
                         padding: const EdgeInsets.all(10),
                         child: Container(
                          child: provider.file == null
                               ? Container(
                            decoration:const BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/login.png'),
                              )
                          ),)
                            : Image.file(
                             provider.file,
                             fit: BoxFit.fill,
                           ),

                         ),
                       ),
                      height: 150,
                     width: 150,
                   ),
            Positioned(
                     top: 150,
                     left: 25,
                     right: 25,
              child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: <Widget>[
               Form(key: provider.productKey,
                child: Column(
                 children: <Widget>[


                 Padding(
                  padding: const EdgeInsets.fromLTRB(80, 0, 0, 10),
                    child: ElevatedButton(
                                 onPressed:()=>provider.selectImage(),

                                 child:const Text(
                                   'Pick image',
                                   textScaleFactor: 2,
                                   style: TextStyle(
                                     fontSize: 10),
                                 ),
                               style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF3E2723),
                                onPrimary: const Color(0xFFFFF3E0),
                                padding:const EdgeInsets.fromLTRB(15, 5, 15, 5)
                               ),),
                 ),

                      const SizedBox(height: 20,),
                        TextFormField(
                   controller:provider.productNameController,
                   validator: (value) => value.isEmpty ? 'You must enter a valid email' : null,
                   decoration: InputDecoration(
                   labelText: "Product name :",
                   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  )
                )),],),),
               const SizedBox(height: 20,),

               ElevatedButton(
                              onPressed: ()  {

                                provider.addProduct();

                                // provider.clearVariables();
                              },


                              child:const Text(
                              'Add product',
                               textScaleFactor: 2,
                               style: TextStyle(
                               fontSize: 18),),
                               style: ElevatedButton.styleFrom(
                               primary: const Color(0xFF3E2723),
                               onPrimary: const Color(0xFFFFF3E0),
                               padding:const EdgeInsets.fromLTRB(15, 5, 15, 5)
                           ),),
                        ],
                    ),
                  ),
                ],
              ),
            ],
          );
      },

       ));
 }
     }

              
                  
                 

                  

                         
              

               
            
           

           

        
            
                        