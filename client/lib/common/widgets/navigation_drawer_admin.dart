import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/features/account/screens/edit_profile_screen.dart';
import 'package:mbschool/features/admin/admin/screens/admin_screen.dart';
import 'package:mbschool/features/admin/users/screens/users_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/create_course/screens/create_course_screen.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class NavigatorDrawerAdmin extends StatelessWidget {
  const NavigatorDrawerAdmin({Key? key}) : super(key: key);

  void logOut(BuildContext context) {
    accountService.logOut(context);
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [buildHeader(context), buildMenuItems(context)],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      color: primary,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: textWhite,
            backgroundImage: NetworkImage(user.photo),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            '${user.nom} ${user.prenom}',
            style: const TextStyle(
                fontSize: 20, color: textWhite, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email,
            style: const TextStyle(fontSize: 16, color: textWhite),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pushNamed(context, BottomBar.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_outlined),
              title: const Text('Admin'),
              onTap: () {
                Navigator.pushNamed(context, AdminScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_outlined),
              title: const Text('Utilisateurs'),
              onTap: () {
                Navigator.pushNamed(context, UsersScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Gestionnaire de cours'),
              onTap: () {
                Navigator.pushNamed(context, CourseManagerScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Créer un cours'),
              onTap: () {
                Navigator.pushNamed(context, CreateCourseScreen.routeName);
              },
            ),
            // const Divider(color: Colors.black54,),
            ListTile(
              leading: const Icon(Icons.sell),
              title: const Text('Rapport de ventes'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.paid_rounded),
              title: const Text('Rapport de paiement'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Se déconnecter'),
              onTap: () {
                logOut(context);
              },
            ),
          ],
        ),
      );
}
