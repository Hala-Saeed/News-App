import 'package:flutter/material.dart';
import 'package:news_app_task/controller/auth_controller.dart';
import 'package:news_app_task/controller/user_information_controller.dart';

import '../widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    super.dispose();
    phoneNumber.dispose();
  }

  var phoneNumber = TextEditingController();
  bool isLoading = false;

  getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  //Text Field
  TextField getTextField(String hint, TextEditingController con) {
    return TextField(
      controller: con,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: getBorder(Colors.grey),
        focusedBorder: getBorder(Colors.blue.shade200),
      ),
    );
  }

  //Login Button
  login() async {
    if(phoneNumber.text.isNotEmpty){
     await UserInformationController().verifyUserAccount(context, phoneNumber.text);
    }

  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextWidget(
            text: 'Log In',
            textColor: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            getTextField('Phone Number', phoneNumber),
            const SizedBox(
              height: 60,
            ),

               InkWell(
                    onTap: login,
                    child: Container(
                      width: 300,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(13),
                        ),
                      ),
                      child: const Center(child: Text('Log In')),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
