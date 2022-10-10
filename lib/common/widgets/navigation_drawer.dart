
import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/create_course/screens/create_course_screen.dart';
import 'package:mbschool/features/panel/panel.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

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
          SizedBox(
            height: 12,
          ),
          CircleAvatar(
            radius: 52,
            backgroundColor: textWhite,
            backgroundImage: NetworkImage(user.photo),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            '${user.nom} ${user.prenom}',
            style: TextStyle(fontSize: 28, color: textWhite),
          ),
          Text(
            "${user.email}",
            style: TextStyle(fontSize: 16, color: textWhite),
          ),
          SizedBox(
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
              onTap: () {},
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
