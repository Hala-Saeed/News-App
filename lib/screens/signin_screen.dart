import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app_task/controller/auth_controller.dart';
import 'package:news_app_task/utils/utilis.dart';

import '../widgets/text_widget.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void dispose() {
    super.dispose();
    name.dispose();
    phoneNumber.dispose();
    occupation.dispose();
  }

  var name = TextEditingController();
  var phoneNumber = TextEditingController();
  var occupation = TextEditingController();
  File? image;
  bool isLoading = false;

  getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  //Pick Image
  pickImage() async {
    image = await pickImageFromGallery(context);
    if (image != null) {
      setState(() {});
    }
  }

  //Text Field
  TextField getTextField(String hint, TextEditingController con) {
    return TextField(
      controller: con,
      keyboardType:
          hint == 'Phone Number' ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: getBorder(Colors.grey),
        focusedBorder: getBorder(Colors.blue.shade200),
      ),
    );
  }

  //Image
  Stack showImage() {
    return Stack(
      children: [
        image == null
            ? const CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(
                    'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg'),
              )
            : CircleAvatar(
                radius: 55,
                backgroundImage: FileImage(image!),
              ),

        //PICKER IMAGE
        Positioned(
          right: -10,
          bottom: -3,
          child: IconButton(
            onPressed: pickImage,
            icon: Icon(
              Icons.add_a_photo,
              size: 25,
              color: Colors.blue.shade400,
            ),
          ),
        ),
      ],
    );
  }

  //Login Button
  signIn() async {
    if (name.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        occupation.text.isNotEmpty) {
      await AuthController().verifyPhone(
          context: context,
          phoneNumber: phoneNumber.text,
          name: name.text,
          occupation: occupation.text,
          image: image);
    } else {
      Fluttertoast.showToast(msg: 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: const TextWidget(
            text: 'Sign In',
            textColor: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                showImage(),
                const SizedBox(
                  height: 60,
                ),
                getTextField('Name', name),
                const SizedBox(
                  height: 30,
                ),
                getTextField('Phone Number', phoneNumber),
                const SizedBox(
                  height: 30,
                ),
                getTextField('Occupation', occupation),
                const SizedBox(
                  height: 60,
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : InkWell(
                        onTap: signIn,
                        child: Container(
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(13),
                            ),
                          ),
                          child: const Center(
                              child: Text('Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
