import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_n_stay_admin/Screens/login.dart';
import 'package:pay_n_stay_admin/Utils/utils.dart';
import 'package:pay_n_stay_admin/resources/auth_merhods.dart';
import 'package:pay_n_stay_admin/widgets/text_form_field.dart';

class ResturantRegistration extends StatefulWidget {
  const ResturantRegistration({Key? key}) : super(key: key);

  @override
  _ResturantRegistrationState createState() => _ResturantRegistrationState();
}

class _ResturantRegistrationState extends State<ResturantRegistration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController locController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  Uint8List? _image;

  //Looding Variable
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
    locController.clear();
    userNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 59, backgroundImage: MemoryImage(_image!))
                      : CircleAvatar(
                          radius: 59,
                          backgroundImage: NetworkImage(
                              'https://static.remove.bg/remove-bg-web/a6eefcd21dff1bbc2448264c32f7b48d7380cb17/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                          onPressed: () => selectImage(),
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          )))
                ],
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter your resturant name',
                textInputType: TextInputType.text,
                controller: userNameController,
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter your resturant email',
                textInputType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                controller: passController,
                isPass: true,
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter your resturant location',
                textInputType: TextInputType.text,
                controller: locController,
              ),
              SizedBox(
                height: 23,
              ),
              InkWell(
                onTap: ResturantRegistrationUsers,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 60,
                        child: Text('Register Resturant'),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        decoration: ShapeDecoration(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)))),
                      ),
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Already an account ?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 9),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => LoginAdmin()));
                    },
                    child: Container(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 9),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  ////Functions///////

  /// Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  ///Register Users
  ResturantRegistrationUsers() async {
    setState(() {
      _isLoading = true;
    });
    String rse = await AuthMethods().ResturantRegistrationUser(
        email: emailController.text,
        pass: passController.text,
        loc: locController.text,
        username: userNameController.text,
        file: _image!);

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse != 'sucess') {
      showSnakBar(rse, context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => LoginAdmin()));
    }
  }
}
