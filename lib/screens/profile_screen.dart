import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app_task/controller/user_information_controller.dart';
import 'package:news_app_task/models/user_model.dart';
import 'package:news_app_task/screens/login_screen.dart';
import 'package:news_app_task/widgets/text_widget.dart';
import '../utils/utilis.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/category-screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        focusedBorder: getBorder(Colors.blue.shade600),
      ),
    );
  }

  //Image
  Stack showImage(String profileUrl) {
    return Stack(
      children: [
        image == null
            ? CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(profileUrl),
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
            icon: const Icon(
              Icons.add_a_photo,
              size: 25,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  //Login Button
  update(String url) async {
    await UserInformationController().saveUserInfoToFireStore(
        context: context, name: name.text, occupation: occupation.text, image: image, url: url);
    Fluttertoast.showToast(msg: 'Profile updated.');
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: const TextWidget(
              text: 'Profile',
              textColor: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(msg: 'Signed out');
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                },
                icon: const Icon(
                  Icons.login_outlined,
                  color: Colors.black,
                )),
          ],
        ),
        body: StreamBuilder<UserModel>(
          stream: UserInformationController().getUserModel(),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                ),
              );
            } else {
              final item = snapshot.data!;
              name.text = item.userName;
              occupation.text = item.occupation;
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        showImage(item.profileUrl),
                        const SizedBox(
                          height: 60,
                        ),
                        getTextField('Name', name),
                        const SizedBox(
                          height: 30,
                        ),
                        getTextField('Occupation', occupation),
                        const SizedBox(
                          height: 60,
                        ),
                        InkWell(
                          onTap: () => update(item.profileUrl),
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
                                child: Text('Update',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
