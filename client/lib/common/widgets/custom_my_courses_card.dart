import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';

class CustomMyCoursesCard extends StatefulWidget {
  const CustomMyCoursesCard({
    Key? key,
    required this.image,
    required this.title,
    required this.instructor,
    required this.videoAmount,
    this.percentage = 0,
    required this.cours,
  }) : super(key: key);

  final String image;
  final String title;
  final String instructor;
  final String videoAmount;
  final double percentage;
  final Cours cours;

  @override
  _CustomMyCoursesCardState createState() => _CustomMyCoursesCardState();
}

class _CustomMyCoursesCardState extends State<CustomMyCoursesCard> {
  CourseManagerService courseManagerService = CourseManagerService();
  int numberLecon = 0;
  int numberLeconDone = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final futureLecon =
          courseManagerService.getNumberLeconCours(context, widget.cours);
      final futureLeconDone =
          courseManagerService.getNumberLeconCoursDone(context, widget.cours);

      final results = await Future.wait([futureLecon, futureLeconDone]);

      setState(() {
        numberLecon = int.tryParse(results[0]) ?? 0;
        numberLeconDone = int.tryParse(results[1]) ?? 0;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  int get progressPercentage {
    if (numberLecon == 0) return 0;
    return ((numberLeconDone / numberLecon) * 100).floor();
  }

  double get progressWidth {
    var size = MediaQuery.of(context).size;
    if (numberLecon == 0) return 0;
    if (progressPercentage == 100)
      return size.width - 30; // Ajustement pour 100%
    return (progressPercentage / 100) *
        (size.width - 30); // -30 pour le padding
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.width * .3,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.width * .13,
                  child: Row(
                    children: [
                      SizedBox(
                        height: size.width * .13,
                        width: size.width * .13,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: miniSpacer),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: secondary,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enseignant: ${widget.instructor}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    color: grey,
                                  ),
                                ),
                                Text(
                                  '$numberLeconDone/$numberLecon',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    color: grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: size.width - 30,
                            height: 5.0,
                            decoration: BoxDecoration(
                              color: secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                          Container(
                            width: progressWidth,
                            height: 7.0,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(100.0),
                              boxShadow: [
                                BoxShadow(
                                  color: primary.withOpacity(0.5),
                                  blurRadius: 6.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: miniSpacer * 2),
                    Container(
                      width: 50,
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$progressPercentage%',
                        style: const TextStyle(
                            fontSize: 13.0,
                            color: primary,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
