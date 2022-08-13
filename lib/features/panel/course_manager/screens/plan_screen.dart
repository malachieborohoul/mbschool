import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_animated_floating_buttons.dart';
import 'package:mbschool/common/widgets/custom_course_section.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/floating_button_provider.dart';
import 'package:provider/provider.dart';

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
  late AnimationController _controller;
  bool isPlay = false;
  bool selected = false;
  bool isScreenTouched = false;
  List<Section> sections = [];
  CourseManagerService courseManagerService = CourseManagerService();

  @override
  void initState() {
    super.initState();
    getAllSections();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  void getAllSections() async {
    sections = await courseManagerService.getAllSections(context, widget.cours);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        body: sections == null ? Loader(): sections.isEmpty? Center(child: Text("Aucune information"),): Container(
          decoration: BoxDecoration(
            color: selected == false ? Colors.white24 : Colors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            // child: Column(
            //   children: [
            //     Text(
            //       "Plan du cours",
            //       style: TextStyle(fontSize: 15),
            //     ),
            //     SizedBox(
            //       height: 20,
            //     ),
            //     CustomCourseSection()
            //   ],
            // ),

            child: ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top:35.0,),
                    child: CustomCourseSection(sections: sections[i]),
                  );
                }),
          ),
        ));
  }
}
