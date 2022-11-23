import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';

class CustomTextFieldExigence extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final maxLines;
  const CustomTextFieldExigence(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.keyboardType,
      this.maxLines =1
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width *0.75,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: textWhite,
           
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade300),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Entrez ${hintText}";
            }
          },
          maxLines: maxLines,
        ),
      ),
    );
  }
}
