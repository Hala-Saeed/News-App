import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery(context) async {
  File? image;
  try{
    final XFile? pickedImage;
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      image = File(pickedImage.path);
    }
  }
  catch(error)
  {
    Fluttertoast.showToast(msg: error.toString());
  }
  return image;
}