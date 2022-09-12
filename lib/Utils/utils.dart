
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//Image Picker Code
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile ? file = await imagePicker.pickImage(source: source);

  if(file != null){
    return await file.readAsBytes();
  }
  print('No Image Selected');
}
 void showDialogBox(BuildContext context){
    showDialog(
         barrierDismissible: false,
         context: context, builder: (_){

       return WillPopScope(
           onWillPop: ()=>Future.value(false),
         child: AlertDialog(
           //alignment: Alignment.center,
           insetPadding: EdgeInsets.zero,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
           title: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               CircularProgressIndicator(color: Colors.black,),
               SizedBox(height: 10,),
               Center(child: Text( "Please wait...")),
             ],
           ),

         ),
       );
     });
     }
   void closeDialog(BuildContext context)
  {
    Navigator.pop(context);
  }

/// SnakBar Code
showSnakBar(String contexts,BuildContext context){
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(contexts)));
}