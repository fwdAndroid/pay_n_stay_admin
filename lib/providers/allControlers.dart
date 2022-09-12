import 'package:flutter/material.dart';

class AllControlers extends ChangeNotifier{
  TextEditingController priceController=TextEditingController();
  TextEditingController typeController=TextEditingController();
  TextEditingController categoryController=TextEditingController();
  TextEditingController titleController=TextEditingController();
  TextEditingController describeController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  priceController.dispose();
  typeController.dispose();
  categoryController.dispose();
  titleController.dispose();
  describeController.dispose();
  }
  void clearControllers(){
    priceController.clear();
    typeController.clear();
    categoryController.clear();
    titleController.clear();
    describeController.clear();

  }
}