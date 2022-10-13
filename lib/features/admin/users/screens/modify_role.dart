import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  UsersManagerService _usersManagerService = UsersManagerService();
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
          ? Loader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: Column(
                  children: [
                    Text(
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
                      child: Container(
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
                              role == 1 ? Icon(Icons.check) : Container()
                            ]),
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    InkWell(
                      splashColor: primary,
                      onTap: () {
                        setState(() {
                          role = 2;
                        });
                      },
                      child: Container(
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
                              role == 2 ? Icon(Icons.check) : Container()
                            ]),
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    InkWell(
                      splashColor: primary,
                      onTap: () {
                        setState(() {
                          role = 3;
                        });
                      },
                      child: Container(
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
                              role == 3 ? Icon(Icons.check) : Container()
                            ]),
                      ),
                    ),
                    SizedBox(
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
                          child: Text(
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
