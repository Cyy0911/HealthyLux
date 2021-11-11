import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux/Components/appbar.dart';
import 'package:healthy_lux/Components/text_form_field.dart';
import 'package:healthy_lux/Model/app_user.dart';
import 'package:healthy_lux/Model/firebase_service.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  String username = "", email = "", age = "", uid = "", result = "";

  final FirebaseService _firebaseService = FirebaseService();

  String imageUrl = "";

  AppUser _appUser = AppUser();

  void saveData() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    await _firebaseService.editUser(username, "${currentUser.email}",
        int.parse(age), imageUrl, double.parse(result));
    Navigator.pop(context);
  }

  Future initData() async {
    try {
      User currentUser = FirebaseAuth.instance.currentUser!;

      _appUser = await _firebaseService.getUserInfoByEmail(currentUser.email!);
      username = _appUser.username;
      email = _appUser.email;
      age = _appUser.age.toString();
      uid = currentUser.uid;
      result = _appUser.result.toString();

      setState(() {
        imageUrl = _appUser.imageUrl;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      // ignore: deprecated_member_use
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);

      // ignore: unnecessary_null_comparison
      if (image != null) {
        var snapshot =
            await _storage.ref().child('Profile Picture/picture').putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        // ignore: avoid_print
        print('No Path Received');
      }
    } else {
      // ignore: avoid_print
      print('Grant Permissions and try again');
    }
  }

  @override
  void initState() {
    super.initState();

    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BuildAppBar(
          title: 'EditProfile',
          backButton: false,
        ),
      ),
      body: editProfileBody(),
    );
  }

  Widget editProfileBody() {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Text(
              "Edit Profile",
              style: AppTheme.defaultTextStyle25Black(false)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            buildProfilePicture(),
            const SizedBox(
              height: 35,
            ),
            Form(
              key: _formKey,
              child: Column(children: [
                BuildTextFormField(output: '').createState().buildTextFormField(
                    "User Name", username, false, false, (value) {
                  if (value.isEmpty) {
                    return null;
                  } else {
                    username = value;
                    return null;
                  }
                }),
                BuildTextFormField(output: '')
                    .createState()
                    .buildTextFormField("E-mail", email, true, false, (value) {
                  if (value.isEmpty) {
                    return null;
                  } else {
                    email = value;
                    return null;
                  }
                }),
                BuildTextFormField(output: '')
                    .createState()
                    .buildTextFormField("Age", age, false, true, (value) {
                  if (value.isEmpty) {
                    return null;
                  } else {
                    age = value;
                    return null;
                  }
                }),
                BuildTextFormField(output: '')
                    .createState()
                    .buildTextFormField("BMI", result, true, false, (value) {
                  if (value.isEmpty) {
                    return null;
                  } else {
                    result = value;
                    return null;
                  }
                }),
              ]),
            ),
            const SizedBox(
              height: 35,
            ),
            saveCancelButton()
          ],
        ),
      ),
    );
  }

  Widget buildProfilePicture() {
    return Center(
      child: Stack(
        children: <Widget>[
          (imageUrl != "")
              ? Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      )),
                )
              : Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/Login.jpg'),
                      )),
                ),
          const SizedBox(
            height: 20.0,
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: AppTheme.greenColor,
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  color: AppTheme.whiteColor,
                  onPressed: () {
                    uploadImage();
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget saveCancelButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ignore: deprecated_member_use
        OutlineButton(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("CANCEL",
              style: AppTheme.defaultTextStyle14Black(false).copyWith(
                letterSpacing: 2.2,
              )),
        ),
        // ignore: deprecated_member_use
        RaisedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              saveData();
            }
          },
          color: AppTheme.greenColor,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            "SAVE",
            style: AppTheme.defaultTextStyle14White(false).copyWith(
              letterSpacing: 2.2,
            ),
          ),
        )
      ],
    );
  }
}
