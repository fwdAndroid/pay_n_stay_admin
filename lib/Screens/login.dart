import 'package:flutter/material.dart';
import 'package:pay_n_stay_admin/Screens/home.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
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
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email'),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffix: Text(
                          'Show',
                          style: TextStyle(color: Colors.blue),
                        ),
                        // 'Show',
                        suffixStyle:
                            TextStyle(color: Colors.blue, fontSize: 20),
                        // style: TextStyle(color: Colors.blue, fontSize: 20),
                        labelText: 'Password'),
                  ),
                  SizedBox(height: 24),

                  // SizedBox(height: 60),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Home()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        primary: Colors.black,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
