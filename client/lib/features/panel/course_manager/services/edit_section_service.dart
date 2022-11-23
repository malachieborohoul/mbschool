import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/models/categorie.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/langue.dart';
import 'package:mbschool/models/niveau.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/section_provider.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSectionService {
  // EDIT SECTION

  void editSection(BuildContext context, Section section, String titre,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resEdit = await http.post(
        Uri.parse('$uri/editSection'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_section': int.parse(section.id_section),
            'titre': titre,
          },
        ),
      );

      httpErrorHandle(
          response: resEdit,
          context: context,
          onSuccess: () {
            Provider.of<SectionProvider>(context, listen: false)
                .setSection(resEdit.body);
            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  // DELETE SECTION

  void deleteSection(BuildContext context, Section section,
      VoidCallback onSuccess) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response resDelete = await http.post(
        Uri.parse('$uri/deleteSection'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id_section': int.parse(section.id_section),
          },
        ),
      );

      httpErrorHandle(
          response: resDelete,
          context: context,
          onSuccess: () {
            
            onSuccess();
          },
          onFailed: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
