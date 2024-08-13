import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_textfield_second.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editProfil';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  TextEditingController localisationController = TextEditingController();
  final _editUserProfileFormKey = GlobalKey<FormState>();

  bool isCharging = false;

  PlatformFile? image;
  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null) return;

    setState(() {
      image = result.files.first;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    prenomController.dispose();
    phoneController.dispose();
    sexeController.dispose();
    localisationController.dispose();
  }

  // void selectImages() async {
  //   var res = await pickImages();
  //   setState(() {
  //     images = res;
  //   });
  // }

  void editUserProfile() {
    accountService.editUserProfile(
        context,
        nameController.text,
        prenomController.text,
        phoneController.text,
        dropdownvalue,
        localisationController.text,
        image!, () {
      setState(() {
        isCharging = false;
      });
    });
  }

  var items = ["M", "F"];

  String dropdownvalue = "M";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (isCharging == false) {
      nameController.text = user.nom.toUpperCase().trim();
      prenomController.text = user.prenom.toUpperCase().trim();
      phoneController.text = user.telephone.toUpperCase().trim();
      sexeController.text = user.sexe.toUpperCase();
      localisationController.text = user.localisation.toUpperCase().trim();
    } else {
      nameController.text = nameController.text.trim();
      prenomController.text = prenomController.text.trim();
      phoneController.text = phoneController.text.trim();
      sexeController.text = sexeController.text.trim();
      localisationController.text = localisationController.text.trim();
    }
    // isCharging == false
    //     ? nameController.text = user.nom.toUpperCase()
    //     : nameController.text = nameController.text;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: CustomAppBar(
              backgroundColor: Colors.transparent,
              action: false,
              actionIcon: 'search_icon.svg',
              title: "Modifier profil",
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(appPadding),
            child: Form(
              key: _editUserProfileFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: spacer,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          image != null
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: Image.file(
                                    File(image!.path!),
                                    width: 100,
                                    height: 100,
                                  ),
                                )
                              : user.photo.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      child: Hero(
                                        tag: 'profile-photo',
                                        child: Image.network(
                                          user.photo,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      child: Hero(
                                        tag: 'profile-photo',
                                        child: Image.asset(
                                          UserProfile['image'].toString(),
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                    ),
                          Positioned(
                            top: 50,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: background,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.camera_alt_rounded)),
                            ),
                          )
                        ],
                      ),

                      Text(
                        user.nom.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // CustomTitle(
                      //   title: '${user.nom.toUpperCase()}',
                      //   extend: false,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "user_icon.svg",
                    labelText: "Nom",
                    controller: nameController,
                    iconColor: primary,
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "user_icon.svg",
                    labelText: "Prenom",
                    controller: prenomController,
                    iconColor: primary,
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "phone_icon.svg",
                    labelText: "Téléphone",
                    controller: phoneController,
                    iconColor: primary,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  CustomTextFieldSecond(
                    prefixIcon: "location_icon.svg",
                    labelText: "Localisation",
                    controller: localisationController,
                    iconColor: primary,
                  ),
                  const SizedBox(
                    height: spacer - 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: primary),
                          ),
                          prefixIcon: Container(
                              height: 50.0,
                              width: 50.0,
                              // color: grey,
                              alignment: Alignment.center,
                              child:
                                  const Icon(Icons.male_sharp, color: primary)),
                        ),
                        value: dropdownvalue,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (String? newval) {
                          setState(() {
                            dropdownvalue = newval!;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: spacer,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (_editUserProfileFormKey.currentState!.validate()) {
                          setState(() {
                            isCharging = true;
                          });
                          editUserProfile();
                        }
                      },
                      child: Column(
                        children: [
                          const CustomButtonBox(title: "Modifier"),
                          isCharging == true
                              ? const CircularProgressIndicator(
                                  color: primary,
                                )
                              : const Text("")
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
