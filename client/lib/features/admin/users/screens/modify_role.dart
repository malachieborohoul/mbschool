import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/admin/users/screens/users_screen.dart';
import 'package:mbschool/features/admin/users/services/users_manager_service.dart';
import 'package:mbschool/models/user.dart';

class ModifyRole extends StatefulWidget {
  const ModifyRole({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ModifyRole> createState() => _ModifyRoleState();
}

late int role;

class _ModifyRoleState extends State<ModifyRole> {
  final UsersManagerService _usersManagerService = UsersManagerService();
  bool isCharging = false;
  @override
  void initState() {
    role = int.parse(widget.user.role);

    super.initState();
  }

  void modifyRole() {
    _usersManagerService.modifyRole(context, widget.user, role, () {
      setState(() {
        isCharging = false;
      });
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pushNamed(UsersScreen.routeName);
      showSnackBar(context, "Role modifié");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isCharging == true
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    const Text(
                      "Modifier rôle",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      splashColor: primary,
                      onTap: () {
                        setState(() {
                          role = 1;
                        });
                      },
                      child: SizedBox(
                        // color: primary,
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Etudiant",
                                style: TextStyle(
                                    fontWeight: role == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              role == 1 ? const Icon(Icons.check) : Container()
                            ]),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    InkWell(
                      splashColor: primary,
                      onTap: () {
                        setState(() {
                          role = 2;
                        });
                      },
                      child: SizedBox(
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Enseignant",
                                style: TextStyle(
                                    fontWeight: role == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              role == 2 ? const Icon(Icons.check) : Container()
                            ]),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    InkWell(
                      splashColor: primary,
                      onTap: () {
                        setState(() {
                          role = 3;
                        });
                      },
                      child: SizedBox(
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Gestionnaire",
                                style: TextStyle(
                                    fontWeight: role == 3
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              role == 3 ? const Icon(Icons.check) : Container()
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCharging = true;
                          modifyRole();
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: primary),
                          child: const Text(
                            "Terminé",
                            style: TextStyle(color: textWhite),
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
