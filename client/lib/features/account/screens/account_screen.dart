import 'package:flutter/material.dart';
import 'package:mbschool/common/animations/slide_down_tween.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_place_holder.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/account/screens/edit_profile_screen.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void logOut(BuildContext context) {
    accountService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            children: [
              const SizedBox(
                height: spacer,
              ),
              SlideDownTween(
                offset: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHeading(
                        title: "Compte",
                        subTitle: user.role == "1" ? "Etudiant" : "",
                        color: secondary),
                    // IconButton(onPressed: (){
                    //    Navigator.pushNamed(
                    //                     context, EditProfileScreen.routeName);
                    // }, icon: Icon(Icons.edit, color: primary),)
                    // InkWell(
                    //   hoverColor: primary,
                    //     onTap: () {
                    //       Navigator.pushNamed(
                    //           context, EditProfileScreen.routeName);
                    //     },
                    //     child: SvgPicture.asset(
                    //       assetImg + 'edit_icon.svg', height: 17,
                    //       color: primary,
                    //     ))
                  ],
                ),
              ),
              const SizedBox(
                height: spacer,
              ),
              user.photo.isNotEmpty
                  ? SlideDownTween(
                      offset: 10,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Hero(
                          tag: 'profile-photo',
                          child: Image.network(
                            user.photo,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircleAvatar(
                              minRadius: 35,
                              maxRadius: 35,
                              backgroundColor: grey,
                            ),
                            SlideDownTween(
                              offset: 30,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                child: Hero(
                                  tag: 'profile-photo',
                                  child: Image.asset(
                                    UserProfile['image'].toString(),
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 65, left: 65),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: background,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, EditProfileScreen.routeName);
                                },
                                hoverColor: primary,
                                icon: const Icon(
                                  Icons.edit,
                                  color: textBlack,
                                )),
                          ),
                        )
                      ],
                    ),
              const SizedBox(
                height: spacer - 40,
              ),
              SlideDownTween(
                offset: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTitle(
                      title: user.nom.toUpperCase(),
                      extend: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: spacer - 40,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //         onTap: () {
              //           Navigator.pushNamed(
              //               context, EditProfileScreen.routeName);
              //         },
              //         child: const Text(
              //           "Modifier profile",
              //           style: TextStyle(color: primary),
              //         ))
              //   ],
              // ),
              const SizedBox(
                height: spacer,
              ),
              const SlideDownTween(
                offset: 30,
                child: CustomTitle(
                  title: "Paramètre",
                  extend: false,
                ),
              ),
              const SizedBox(
                height: spacer - 25,
              ),
              SlideDownTween(
                offset: 30,
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CunstomPlaceHolder(title: "A propos de nous"),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: spacer - 30,
              ),
              GestureDetector(
                  onTap: () {
                    logOut(context);
                  },
                  child: const SlideDownTween(
                      offset: 30,
                      child: CustomButtonBox(title: "Se déconnecter"))),
              const SizedBox(
                height: spacer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
