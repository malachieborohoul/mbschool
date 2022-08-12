import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/features/panel/panel.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/features/auth/services/auth_service.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:mbschool/router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
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
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    initialization();
    authService.getUserData(context);
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    MaterialApp(
      home: Scaffold(
        body: Text("MBSCHOOL"),
      ),
    );
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "WorkSans"),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (setting) => generateRoute(setting),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.role == "1"
              ? BottomBar()
              : Panel()
          : AuthScreen(),
    );
  }
}
