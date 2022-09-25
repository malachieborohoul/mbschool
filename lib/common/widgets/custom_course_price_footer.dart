import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/alert_notification.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/course/services/course_enrollment_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:provider/provider.dart';

import 'custom_button_box.dart';

CourseEnrollmentService courseEnrollmentService = CourseEnrollmentService();

class CustomCoursePriceFooter extends StatelessWidget {
  const CustomCoursePriceFooter({
    Key? key,
    this.coursePrice = '',
    this.enrolled = false,
    required this.cours,
  }) : super(key: key);

  final String coursePrice;
  final bool enrolled;
  final Cours cours;

  @override
  Widget build(BuildContext context) {
    

    var size = MediaQuery.of(context).size;
    return (enrolled)
        ? Container(
            width: size.width,
            height: 100.0,
            padding: const EdgeInsets.all(appPadding),
            decoration: BoxDecoration(
              color: textWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: CustomButtonBox(title: 'Continuer le cours'),
          )
        : Container(
            width: size.width*0.4,
            height: 100.0,
            padding: const EdgeInsets.only(
              left: appPadding,
              right: appPadding,
              top: appPadding,
            ),
            decoration: BoxDecoration(
              color: textWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prix',
                        style: TextStyle(fontSize: 12.0, color: grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        cours.prix.isEmpty ? "Gratuit" : cours.prix,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: third,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: miniSpacer + 5),
               
              ],
            ),
          );
  }
}
