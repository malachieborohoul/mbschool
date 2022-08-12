import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/alert_dialog_add_lecon.dart';
import 'package:mbschool/common/widgets/alert_dialog_add_section.dart';
import 'package:mbschool/common/widgets/custom_animated_button.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/providers/floating_button_provider.dart';
import 'package:provider/provider.dart';

class CustomAnimatedFloatingButtons extends StatefulWidget {
  final Cours cours;
  bool? selected;
  bool? isPlay;
  bool? isScreenTouched;
  final VoidCallback onSuccess;

  CustomAnimatedFloatingButtons(
      {Key? key,
      this.selected,
      this.isPlay,
      required this.onSuccess,
      required this.cours})
      : super(key: key);

  @override
  State<CustomAnimatedFloatingButtons> createState() =>
      _CustomAnimatedFloatingButtonsState();
}

class _CustomAnimatedFloatingButtonsState
    extends State<CustomAnimatedFloatingButtons> with TickerProviderStateMixin {
  double width = 50;
  double height = 50;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black26,
      width: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomAnimatedButton(
            selected: widget.selected!,
            width: width,
            height: height,
            bottom: 20,
            top: 150,
            milliseconds: 500,
            text: 'Ajouter section',
            icon: Icons.add,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialogAddSection(
                        cours: widget.cours,
                      ));
            },
          ),
          CustomAnimatedButton(
            selected: widget.selected!,
            width: width,
            height: height,
            bottom: 20,
            top: 280,
            milliseconds: 400,
            text: "Ajouter leçon",
            icon: Icons.add_card_outlined,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialogAddLecon(
                        cours: widget.cours,
                      ));
            },
          ),
          CustomAnimatedButton(
            selected: widget.selected!,
            width: width,
            height: height,
            bottom: 20,
            top: 410,
            milliseconds: 300,
            text: "Trier",
            icon: Icons.sort,
            onTap: () {},
          ),
          Container(
            margin: EdgeInsets.only(left: 150),
            width: 70,
            height: 70,
            child: FloatingActionButton(
              backgroundColor: widget.isPlay == false ? primary : Colors.red,
              onPressed: () {
                if (widget.isPlay == false) {
                  setState(() {
                    _controller.forward();
                    widget.isPlay = true;
                    widget.selected = true;
                    widget.onSuccess();
                  });
                } else {
                  setState(() {
                    _controller.reverse();
                    widget.isPlay = false;
                    widget.selected = false;
                    widget.onSuccess();
                  });
                }
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _controller,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
