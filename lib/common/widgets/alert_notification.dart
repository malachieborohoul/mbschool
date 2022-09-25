import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:mbschool/common/animations/slide_up_tween.dart';
import 'package:mbschool/constants/colors.dart';

class AlertNotification extends StatefulWidget {
  const AlertNotification({Key? key, required this.message,  this.error=true}) : super(key: key);

  final String message;
  final bool error;

  @override
  State<AlertNotification> createState() => _AlertNotificationState();
}

class _AlertNotificationState extends State<AlertNotification> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SlideUpTween(
          curve: Curves.bounceOut,
          duration: Duration(milliseconds: 700),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 80,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 254, 254),
                ),
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: widget.error==true? Colors.red:Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Center(child:  Icon( widget.error==true?Icons.close:Icons.check, color: Colors.black)),
                          ),

                      SizedBox(width: 25,),
                      Flexible(
                        child: Text(
                          widget.message,
                          style: TextStyle(color: textBlack, fontSize: 12),
                        ),
                      )
                    ])),
              ),
            ),
          ),
          offset: 300),
    );
  }
}
