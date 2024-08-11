import 'package:flutter/material.dart';

import 'package:mbschool/common/widgets/custom_animated_floating_buttons.dart';
import 'package:mbschool/common/widgets/custom_course_section.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';

import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';

class PlanScreen extends StatefulWidget {
  static const routeName = '/plan_cours';
  final Cours cours;
  const PlanScreen({
    Key? key,
    required this.cours,
  }) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> with TickerProviderStateMixin {
  bool isPlay = false;
  bool selected = false;
  bool isScreenTouched = false;
  late Future<List<Section>> sections;
  CourseManagerService courseManagerService = CourseManagerService();

  @override
  void initState() {
    super.initState();
    getAllSections();
  }

  void getAllSections() {
    sections = courseManagerService.getAllSections(context, widget.cours);
    setState(() {
      // print(sections.length);
    });
  }

  List<Lecon> lecons = [];
  // CourseManagerService courseManagerService = CourseManagerService();
  void getAllLecons(Section? section) async {
    lecons = await courseManagerService.getAllLecons(context, section!);
    setState(() {
      // print(lecons);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: textBlack,
          backgroundColor: textWhite,
          elevation: 0,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Text(widget.cours.titre),
        ),
        floatingActionButton: CustomAnimatedFloatingButtons(
          cours: widget.cours,
          selected: selected,
          isPlay: isPlay,
          onSuccess: () {
            setState(() {
              selected = !selected;
              isPlay = !isPlay;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body:
            // sections == null
            //     ? const Loader()
            //     : sections.isEmpty
            //         ? const Center(
            //             child: Text("Aucune information"),
            //           )
            //         :

            FutureBuilder(
              future: sections,
                builder: (context, AsyncSnapshot<List<Section>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
             return snapshot.data!.isEmpty? const Center(child: Text("Aucunes informations"),): Container(
            decoration: BoxDecoration(
              color: selected == false ? Colors.white10 : Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
            

              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 35.0,
                      ),
                      child: CustomCourseSection(sections: snapshot.data![i]),
                    );
                  }),
            ),
          );
          } else {
            return const Loader();
          }
        }));
  }
}
