
import 'package:flutter/material.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/intro/screens/splash_screen.dart';
import 'package:mbschool/features/auth/services/auth_service.dart';
import 'package:mbschool/providers/course_plan_provider.dart';
import 'package:mbschool/providers/course_provider.dart';
import 'package:mbschool/providers/lecon_provider.dart';
import 'package:mbschool/providers/number_entry_provider.dart';
import 'package:mbschool/providers/search_user_provider.dart';
import 'package:mbschool/providers/section_provider.dart';
import 'package:mbschool/providers/tabbar_provider.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:mbschool/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => SearchUserProvider()),
      ChangeNotifierProvider(create: (context) => CoursPlanProvider()),
      ChangeNotifierProvider(create: (context) => CoursProvider()),
      ChangeNotifierProvider(create: (context) => TabBarProvider()),
      ChangeNotifierProvider(create: (context) => NumberEntryProvider()),
      ChangeNotifierProvider(create: (context) => SectionProvider()),
      ChangeNotifierProvider(create: (context) => LeconProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternet = false;

  AuthService authService = AuthService();
  // List<User> userList = [];

  @override
  void initState() {
    // getConnectivity();
    super.initState();
    // getUserData();
    // initialization();
  }



  @override
  void dispose() {
    super.dispose();
  }
  // void getUserData() async {
  //   userList = await authService.getUserData(context);
  // }

  // void initialization() async {
  // This is where you can initialize the resources needed by your app while
  // the splash screen is displayed.  Remove the following example because
  // delaying the user experience is a bad design practice!
  // ignore_for_file: avoid_print
  //   MaterialApp(
  //     home: Scaffold(
  //       body: Text("MBSCHOOL"),
  //     ),
  //   );
  //   print('ready in 3...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('ready in 2...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('ready in 1...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('go!');
  //   FlutterNativeSplash.remove();
  // }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        // ERROR HANDLED BY FLUTTER
        builder: (context, widget) {
          Widget error = Image.asset("${assetImg}error_handle.png");
          if (widget is Scaffold || widget is Navigator) {
            error = Scaffold(body: Center(child: error));
          }
          ErrorWidget.builder = (errorDetails) => error;
          if (widget != null) return widget;
          throw ('widget is null');
        },
        theme: ThemeData(fontFamily: "WorkSans"),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (setting) => generateRoute(setting),
        home: const SplashScreen());
  }
}

// Provider.of<UserProvider>(context).user.token.isNotEmpty
//           ? Provider.of<UserProvider>(context).user.role == "1"
//               ? BottomBar()
//               : Panel()
//           : AuthScreen(),
