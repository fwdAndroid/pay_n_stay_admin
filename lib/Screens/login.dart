import 'package:flutter/material.dart';
import 'package:pay_n_stay_admin/Screens/home.dart';
import 'package:pay_n_stay_admin/Utils/utils.dart';
import 'package:pay_n_stay_admin/auth/resturantregister.dart';
import 'package:pay_n_stay_admin/resources/auth_merhods.dart';
import 'package:pay_n_stay_admin/widgets/text_form_field.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    "Welcome To \n  Pay'n'Stay",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),

                  SizedBox(height: 40),
                  TextFormInputField(
                    hintText: 'Enter youe email',
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  SizedBox(height: 40),
                  TextFormInputField(
                    hintText: 'Enter youe password',
                    textInputType: TextInputType.visiblePassword,
                    controller: passController,
                    isPass: true,
                  ),
                  SizedBox(height: 24),

                  // SizedBox(height: 60),
                  InkWell(
                    onTap: loginUser,
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: 60,
                            child: Text('Login'),
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
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ResturantRegistration()));
                },
                child: Text("Register Your Resturant"))
          ],
        ),
      ),
    );
    ;
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String rse = await AuthMethods().loginUpUser(
      email: emailController.text,
      pass: passController.text,
    );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse == 'sucess') {
      Navigator.push(context, MaterialPageRoute(builder: (builder) => Home()));
    } else {
      showSnakBar(rse, context);
    }
  }
}
