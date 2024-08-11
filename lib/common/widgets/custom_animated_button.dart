import 'package:flutter/material.dart';
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
              duration: const Duration(seconds: 1),
              curve: Curves.bounceInOut,
              child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                height: widget.selected == false ? 0 : 25,
                width: widget.selected == false ? 0 : 120,
                decoration: const BoxDecoration(
                    color: secondary,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                    child: Text(
                  widget.text,
                  style: const TextStyle(color: textWhite),
                )),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
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
                      ? const Text("")
                      : Icon(widget.icon, color: textWhite),
                ),
              ),
            ),
          ],
        ));
  }
}
