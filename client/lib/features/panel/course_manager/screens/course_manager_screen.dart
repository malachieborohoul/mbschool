import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/custom_card.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/common/widgets/navigation_drawer_admin.dart';
import 'package:mbschool/common/widgets/navigation_drawer_teacher.dart';
import 'package:mbschool/common/widgets/nodata.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CourseManagerScreen extends StatefulWidget {
  static const routeName = '/course_manager';
  const CourseManagerScreen({Key? key}) : super(key: key);

  @override
  State<CourseManagerScreen> createState() => _CourseManagerScreenState();
}

class _CourseManagerScreenState extends State<CourseManagerScreen> {
  CourseManagerService courseManagerService = CourseManagerService();
  late Future<List<Cours>> cours;
  @override
  void initState() {
    getAllCoursesTeacher();

    super.initState();
  }

  void getAllCoursesTeacher() {
    cours = courseManagerService.getAllCoursesTeacher(context);
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
              : const NavigatorDrawerAdmin(),
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 1,
        title: const Text("Gestionnaire de cours"),
      ),
      body:
          // cours == null
          //     ? const Center(
          //         child: CircularProgressIndicator(
          //           color: primary,
          //         ),
          //       )
          //     : cours.isEmpty
          //         ? const NoData()
          //         :
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: FutureBuilder(
                  future: cours,
                  builder: (context, AsyncSnapshot<List<Cours>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data!.isEmpty
                          ? const NoData()
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PlanScreen.routeName,
                                          arguments: snapshot.data![i]);
                                    },
                                    child:
                                        CustomCard(cours: snapshot.data![i]));
                              });
                    } else {
                      return const Loader();
                    }
                  })

              // child: Column(
              //   children: [CustomCard()],
              // ),
              ),
    );
  }
}
