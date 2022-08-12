import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/models/langue.dart';

class CustomDropdownButtonLangue extends StatefulWidget {
  final List<Langue> items;
  
  CustomDropdownButtonLangue({Key? key, required this.items,}) : super(key: key);

  @override
  State<CustomDropdownButtonLangue> createState() =>
      _CustomDropdownButtonLangueState();
}

class _CustomDropdownButtonLangueState extends State<CustomDropdownButtonLangue> {
  
  @override
  Widget build(BuildContext context) {
    
   
    String dropdownvalue = widget.items[0].id_langue;
    return DropdownButtonFormField(
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
        value: dropdownvalue,
        items: widget.items.map((Langue item) {
          return DropdownMenuItem(
            child: Text(item.nom),
            value: item.id_langue,
          );
        }).toList(),
        onChanged: (String? val) {
          setState(() {
            dropdownvalue = val!;
          });
        });
  }
}
