import 'package:flutter/material.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/models/langue.dart';

class CustomDropdownButtonLangue extends StatefulWidget {
  final List<Langue> items;
  
  const CustomDropdownButtonLangue({super.key, required this.items,});

  @override
  State<CustomDropdownButtonLangue> createState() =>
      _CustomDropdownButtonLangueState();
}

class _CustomDropdownButtonLangueState extends State<CustomDropdownButtonLangue> {
  
  @override
  Widget build(BuildContext context) {
    
   
    String dropdownvalue = widget.items[0].idLangue;
    return DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: textWhite,
          hintText: "Selectionner",
          hintStyle: TextStyle(color: Colors.grey.shade300),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        initialValue: dropdownvalue,
        items: widget.items.map((Langue item) {
          return DropdownMenuItem(
            value: item.idLangue,
            child: Text(item.nom),
          );
        }).toList(),
        onChanged: (String? val) {
          setState(() {
            dropdownvalue = val!;
          });
        });
  }
}
