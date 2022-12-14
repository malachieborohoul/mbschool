import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/navigation_drawer_admin.dart';
import 'package:mbschool/common/widgets/navigation_drawer_teacher.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/admin/admin/screens/categorie_screen.dart';
import 'package:mbschool/features/admin/admin/screens/langue_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/user.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = 'admin-screen';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<User> users = [];
  List<Cours> cours = [];

  CourseManagerService _courseManagerService = CourseManagerService();

  @override
  void initState() {
    getAllUsers();
    getAllCours();
    super.initState();
  }

  void getAllUsers() async {
    users = await _courseManagerService.getAllUsers(context);
    setState(() {});
  }

  void getAllCours() async {
    cours = await _courseManagerService.getAllCourses(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      drawer: user.role == "1"
          ? Container()
          : user.role == "2"
              ? const NavigatorDrawerTeacher()
              : NavigatorDrawerAdmin(),
      appBar: AppBar(
        foregroundColor: textBlack,
        backgroundColor: textWhite,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text("Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: SingleChildScrollView(
            child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CategorieScreen.routeName);
                },
                child: CustomButtonBox(title: "Ajouter categorie")),
            SizedBox(
              height: appPadding,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LangueScreen.routeName);
                },
                child: CustomButtonBox(title: "Ajouter langue")),
            SizedBox(
              height: appPadding + 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Utilisateurs"), Text("${users.length}")],
            ),
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Cours"), Text("${cours.length}")],
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        )),
      ),
    );
  }
}
