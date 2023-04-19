import 'package:flutter/material.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/datas/user_profile.dart';

class CustomPersonCard extends StatelessWidget {
  const CustomPersonCard({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCourses,
    required this.totalStudents,
  }) : super(key: key);

  final String image;
  final String name;
  final String totalCourses;
  final String totalStudents;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .6,
      height: size.width * .3,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.width * .125,
            child: Row(
              children: [
                SizedBox(
                  width: size.width * .125,
                  height: size.width * .125,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: image.isNotEmpty
                        ? Image.network(image, fit: BoxFit.cover)
                        : Image.asset(
                            UserProfile['image'].toString(),
                            width: 100,
                            height: 100,
                          ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: secondary,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$totalCourses Courses',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: primary,
                  ),
                ),
                Text(
                  '$totalStudents Students',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
