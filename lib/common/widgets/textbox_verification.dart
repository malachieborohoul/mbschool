import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';

class TextBoxVerification extends StatefulWidget {
  const TextBoxVerification({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  State<TextBoxVerification> createState() => _TextBoxVerificationState();
}

class _TextBoxVerificationState extends State<TextBoxVerification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: 43,
      height: 48,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: (val) {
              if (val == null || val.isEmpty) {
                // return "Entrez votre ${widget.labelText}";
              }
              return null;
            },
      ),
    );
  }
}
