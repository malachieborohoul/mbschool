import 'package:flutter/material.dart';

import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/services/plan.service.dart';

class AlertDialogError extends StatefulWidget {
  final String texte;
  const AlertDialogError({Key? key,  required this.texte}) : super(key: key);

  @override
  State<AlertDialogError> createState() => _AlertDialogErrorState();
}

enum type_lecon { video, document }

class _AlertDialogErrorState extends State<AlertDialogError> {

  TextEditingController titreSectionController = TextEditingController();

  PlanService planService = PlanService();

  @override
  void dispose() {
    super.dispose();
    titreSectionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
 

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.warning, color: Colors.red,),
              const Text("Attention", style: TextStyle(color: Colors.red),),
              
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: textWhite,
                        ),
                      )))
            ],
          ),
          content: SizedBox(
            height: 80,
            child: Column(
              children: [
                Flexible(
                    child: Text(
                  widget.texte,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
               
              ],
            ),
          ),
          
        ));
  }
}
