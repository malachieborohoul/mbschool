import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';

class CustomCourseCurriculum extends StatelessWidget {
  const CustomCourseCurriculum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Introduction"),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_up_rounded))
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text("00:20:30", style: TextStyle(fontSize: 12))),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 20,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text(
                    "10 leçons",
                    style: TextStyle(fontSize: 12),
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 15,
                ),
                SizedBox(
                  width: 8,
                ),
                Text("Introduction au développement"),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 15,
                ),
                SizedBox(
                  width: 8,
                ),
                Text("Introduction au développement"),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 15,
                ),
                SizedBox(
                  width: 8,
                ),
                Text("Introduction au développement"),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
