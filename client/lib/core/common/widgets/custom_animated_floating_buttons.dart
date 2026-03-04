import 'package:flutter/material.dart';
import 'package:mbschool/core/common/widgets/alert_dialog_add_lecon.dart';
import 'package:mbschool/core/common/widgets/alert_dialog_add_section.dart';
import 'package:mbschool/core/common/widgets/alert_dialog_error.dart';
import 'package:mbschool/core/common/widgets/custom_animated_button.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/section.dart';
class CustomAnimatedFloatingButtons extends StatefulWidget {
  final Cours cours;
  final VoidCallback onSuccess;
  
  // These are now final. They act as the INITIAL state.
  final bool initialSelected;
  final bool initialIsPlay;

  const CustomAnimatedFloatingButtons({
    super.key,
    this.initialSelected = false,
    this.initialIsPlay = false,
    required this.onSuccess,
    required this.cours, required bool selected, required bool isPlay,
  });

  @override
  State<CustomAnimatedFloatingButtons> createState() =>
      _CustomAnimatedFloatingButtonsState();
}

class _CustomAnimatedFloatingButtonsState
    extends State<CustomAnimatedFloatingButtons> with TickerProviderStateMixin {
  
  // 1. Mutable state lives here
  late bool isSelected;
  late bool isPlay;
  
  double width = 50;
  double height = 50;
  late AnimationController _controller;

  List<Section> sections = [];
  CourseManagerService courseManagerService = CourseManagerService();

  @override
  void initState() {
    super.initState();
    // 2. Initialize state from widget properties
    isSelected = widget.initialSelected;
    isPlay = widget.initialIsPlay;
    
    getAllSections();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
        
    if (isPlay) _controller.value = 1.0; // Ensure icon matches state
  }

  void getAllSections() async {
    sections = await courseManagerService.getAllSections(context, widget.cours);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sub-buttons use the local 'isSelected' state
          CustomAnimatedButton(
            selected: isSelected,
            width: width, height: height, bottom: 20, top: 150,
            milliseconds: 500, text: 'Ajouter section', icon: Icons.add,
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialogAddSection(cours: widget.cours),
            ),
          ),
          CustomAnimatedButton(
            selected: isSelected,
            width: width, height: height, bottom: 20, top: 280,
            milliseconds: 400, text: "Ajouter leçon", icon: Icons.add_card_outlined,
            onTap: () {
              if (sections.isEmpty) {
                showDialog(context: context, builder: (context) => const AlertDialogError(texte: "Veuillez d'abord créer une section!"));
              } else {
                showDialog(context: context, builder: (context) => AlertDialogAddLecon(cours: widget.cours));
              }
            },
          ),
          CustomAnimatedButton(
            selected: isSelected,
            width: width, height: height, bottom: 20, top: 410,
            milliseconds: 300, text: "Trier", icon: Icons.sort,
            onTap: () {},
          ),
          
          // Main Toggle Button
          Container(
            margin: const EdgeInsets.only(left: 150),
            width: 70, height: 70,
            child: FloatingActionButton(
              backgroundColor: !isPlay ? primary : Colors.red,
              onPressed: () {
                setState(() {
                  if (!isPlay) {
                    _controller.forward();
                    isPlay = true;
                    isSelected = true;
                  } else {
                    _controller.reverse();
                    isPlay = false;
                    isSelected = false;
                  }
                });
                widget.onSuccess(); // Notify parent
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