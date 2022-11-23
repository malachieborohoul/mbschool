import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';

class CustomAnimatedButton extends StatefulWidget {
  final bool selected;
  final double width;
  final double height;
  final double bottom;
  final double top;
  final int milliseconds;
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  const CustomAnimatedButton(
      {Key? key,
      required this.selected,
      required this.width,
      required this.height,
      required this.bottom,
      required this.top,
      required this.milliseconds,
      required this.text,
      required this.icon, required this.onTap})
      : super(key: key);

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
        padding: widget.selected == false
            ? EdgeInsets.only(bottom: widget.bottom)
            : EdgeInsets.only(top: widget.top),
        duration: Duration(milliseconds: widget.milliseconds),
        curve: Curves.fastOutSlowIn,
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.bounceInOut,
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                height: widget.selected == false ? 0 : 25,
                width: widget.selected == false ? 0 : 120,
                decoration: BoxDecoration(
                    color: secondary,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                    child: Text(
                  widget.text,
                  style: TextStyle(color: textWhite),
                )),
              ),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.bounceInOut,
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  height: widget.selected == false ? 0 : widget.height,
                  width: widget.selected == false ? 0 : widget.width,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: widget.selected == false
                      ? Text("")
                      : Icon(widget.icon, color: textWhite),
                ),
              ),
            ),
          ],
        ));
  }
}
