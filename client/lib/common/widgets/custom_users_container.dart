import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/user.dart';

class CustomUsersContainer extends StatefulWidget {
  const CustomUsersContainer({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<CustomUsersContainer> createState() => _CustomUsersContainerState();
}

class _CustomUsersContainerState extends State<CustomUsersContainer> {
  final CourseManagerService _courseManagerService = CourseManagerService();
  List<Cours> courseTaking = [];
  List<Cours> courseTeaching = [];
  List<User> totalStudents = [];
  @override
  void initState() {
    super.initState();
    getAllTakingCourses();
    getAllTeachingCourses();
    getTotalStudents();
  }

  void getAllTakingCourses() async {
    courseTaking =
        await _courseManagerService.getAllTakingCourses(context, widget.user);
    setState(() {});
  }

  void getAllTeachingCourses() async {
    courseTeaching =
        await _courseManagerService.getAllTeachingCourses(context, widget.user);
    setState(() {});
  }

  void getTotalStudents() async {
    totalStudents =
        await _courseManagerService.getTotalStudents(context, widget.user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return courseTaking == null ||
            courseTeaching == null ||
            totalStudents == null
        ? const Loader()
        : Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.user.photo.isNotEmpty
                    ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.user.photo),
                    )
                    : ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          UserProfile['image'].toString(),
                          width: 50,
                          height: 50,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.user.nom} ${widget.user.prenom}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cours suivis: ${courseTaking.length} - Cours enseignés ${courseTeaching.length} - Etudiants ${totalStudents.length}",
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 15,
                )
              ],
            ),
          );
  }
}
