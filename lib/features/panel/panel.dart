import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/navigation_drawer_teacher.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';

class Panel extends StatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  State<Panel> createState() => _PanelState();
}
void logOut(BuildContext context) {
    accountService.logOut(context);
  }


class _PanelState extends State<Panel> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MBSCHOOL'),
        backgroundColor: primary,
      ),
      drawer: const NavigatorDrawerTeacher(),
    );
  }
}

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Drawer(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [buildHeader(context), buildMenuItems(context)],
//           ),
//         ),
//       );

//   Widget buildHeader(BuildContext context) => Container(
//         color: primary,
//         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 12,
//             ),
//             CircleAvatar(
//               radius: 52,
//               backgroundColor: textWhite,
//             ),
//             SizedBox(
//               height: 12,
//             ),
//             Text(
//               "BSM",
//               style: TextStyle(fontSize: 28, color: textWhite),
//             ),
//             Text(
//               "bsm@gmail.com",
//               style: TextStyle(fontSize: 16, color: textWhite),
//             ),
//             SizedBox(
//               height: 12,
//             ),
//           ],
//         ),
//       );

//   Widget buildMenuItems(BuildContext context) => Container(
//         padding: const EdgeInsets.all(24),
//         child: Wrap(
//           runSpacing: 16,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.store),
//               title: const Text('Gestionnaire de cours'),
//               onTap: () {
//                 Navigator.pushNamed(context, CourseManagerScreen.routeName);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text('Créer un cours'),
//               onTap: () {
//                 Navigator.pushNamed(context, CreateCourseScreen.routeName);
//               },
//             ),
//             // const Divider(color: Colors.black54,),
//             ListTile(
//               leading: const Icon(Icons.sell),
//               title: const Text('Rapport de ventes'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.paid_rounded),
//               title: const Text('Rapport de paiement'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Profil'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Se déconnecter'),
//               onTap: () {
//                 logOut(context);
//               },
//             ),
//           ],
//         ),
//       );
// }
