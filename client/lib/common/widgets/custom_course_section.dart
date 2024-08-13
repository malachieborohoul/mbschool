import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/custom_course_lecon.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/features/panel/course_manager/screens/edit_section_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/section_provider.dart';
import 'package:provider/provider.dart';

class CustomCourseSection extends StatefulWidget {
  final Section sections;
  const CustomCourseSection({Key? key, required this.sections})
      : super(key: key);

  @override
  State<CustomCourseSection> createState() => _CustomCourseSectionState();
}

class _CustomCourseSectionState extends State<CustomCourseSection> {
  late Future<List<Lecon>> lecons;
  CourseManagerService courseManagerService = CourseManagerService();

  @override
  void initState() {
    super.initState();
    getAllLecons();
  }

  void getAllLecons() {
    lecons = courseManagerService.getAllLecons(context, widget.sections);
    setState(() {
      // print(lecons.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: FutureBuilder(
          future: lecons,
          builder: (context, AsyncSnapshot<List<Lecon>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.sections.titre),
                              GestureDetector(
                                child: PopupMenuButton(onSelected: (value) {
                                  if (value == 1) {
                                    Navigator.pushNamed(
                                        context, EditSectionScreen.routeName,
                                        arguments: widget.sections);

                                    Provider.of<SectionProvider>(context,
                                            listen: false)
                                        .set_section(widget.sections);
                                  }
                                }, itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 1,
                                      child: const Text("Modifier section"),
                                      onTap: () {},
                                    ),
                                  ];
                                }),
                              )
                            ],
                          ),
                          // BOuble pour afficher le nombre de lecons appartenant à cette section
                          for (int i = 0; i < snapshot.data!.length; i++)
                            CustomCourseLecon(
                              lecon: snapshot.data![i],
                            ),

                          // ListView.builder(
                          //     itemCount: lecons.length,
                          //     itemBuilder: (context, i) {
                          //       return Padding(
                          //         padding: const EdgeInsets.only(
                          //           top: 35.0,
                          //         ),
                          //         child: CustomCourseLecon(),
                          //       );
                          //     }),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.sections.titre),
                              GestureDetector(
                                child: PopupMenuButton(onSelected: (value) {
                                  if (value == 1) {
                                    Navigator.pushNamed(
                                        context, EditSectionScreen.routeName,
                                        arguments: widget.sections);

                                    Provider.of<SectionProvider>(context,
                                            listen: false)
                                        .set_section(widget.sections);
                                  }
                                }, itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 1,
                                      child: const Text("Modifier section"),
                                      onTap: () {},
                                    ),
                                  ];
                                }),
                              )
                            ],
                          ),
                          // BOuble pour afficher le nombre de lecons appartenant à cette section
                          for (int i = 0; i < snapshot.data!.length; i++)
                            CustomCourseLecon(
                              lecon: snapshot.data![i],
                            ),

                          // ListView.builder(
                          //     itemCount: lecons.length,
                          //     itemBuilder: (context, i) {
                          //       return Padding(
                          //         padding: const EdgeInsets.only(
                          //           top: 35.0,
                          //         ),
                          //         child: CustomCourseLecon(),
                          //       );
                          //     }),
                        ],
                      ),
                    );
            } else {
              return const Loader();
            }
          }),
    );
  }
}
