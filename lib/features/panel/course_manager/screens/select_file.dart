import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_textfield_panel.dart';
import 'package:mbschool/common/widgets/custom_title_panel.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/section.dart';

class SelectFile extends StatefulWidget {
  static const routeName = '/select-file';
  final codeFile;
  final Cours cours;
  const SelectFile({Key? key, this.codeFile, required this.cours})
      : super(key: key);

  @override
  State<SelectFile> createState() => _SelectFileState();
}

class _SelectFileState extends State<SelectFile> {
  List<Section> sections = [];
  CourseManagerService courseManagerService = CourseManagerService();
  TextEditingController titreEditingController = TextEditingController();
  TextEditingController resumeEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllSections();
  }

  void getAllSections() async {
    sections = await courseManagerService.getAllSections(context, widget.cours);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String? dropdownvalue_section =
        sections[0].id_section;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: textBlack,
        backgroundColor: textWhite,
        title: Text(
          "Ajouter une nouvelle leçon",
          style: TextStyle(color: textBlack),
        ),
        elevation: 1,
      ),
      body:  Padding(
              padding: const EdgeInsets.all(appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Créer une leçon: ${widget.codeFile == 1 ? "Vidéo" : "Document"}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: appPadding,
                  ),
                  const CustomTitlePanel(title: "Titre"),
                  const SizedBox(
                    height: appPadding - 20,
                  ),

                  CustomTextFieldPanel(
                      hintText: "Titre",
                      prefixIcon: Icons.title,
                      controller: titreEditingController),

                  // DROPDOWN BUTTON SECTION

                 DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textWhite,
                        hintText: "Selectionner",
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: dropdownvalue_section,
                      items: sections.map((Section item) {
                        return DropdownMenuItem(
                          child: Text(item.titre),
                          value:  item.id_section,
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        setState(() {
                          dropdownvalue_section = val!;
                        });
                      }),
                ],
              ),
            ),
    );
  }
}
