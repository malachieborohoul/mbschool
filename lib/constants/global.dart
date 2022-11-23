import 'package:flutter/material.dart';
import 'package:mbschool/features/account/services/account_service.dart';
import 'package:mbschool/features/auth/services/auth_service.dart';
import 'package:mbschool/features/panel/create_course/services/create_course_service.dart';

// String uri = "http://192.168.2.22:3000";
// String uri = "http://192.168.2.23:3000";
String uri = "http://192.168.43.144:3000";
// String uri = "http://192.168.43.72:3000";

// String uri = "http://192.168.100.39:3000";
// String uri = "http://192.168.137.88:3000";


AuthService authService = AuthService();
AccountService accountService = AccountService();
CreateCourseService createCourseService = CreateCourseService();
bool isCharging = false;

// POur le custom floating button

class introApp {
  static int num = 0;
}
