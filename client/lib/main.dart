import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mbschool/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';
import 'package:mbschool/core/l10n/l10n.dart';
import 'package:mbschool/core/utils/size_utils.dart';
import 'package:mbschool/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mbschool/features/auth/presentation/providers/language_provider.dart';
import 'package:mbschool/features/auth/presentation/screens/splash_screen.dart';
import 'package:mbschool/features/autht/services/auth_service.dart';
import 'package:mbschool/init_dependencies.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiProvider(
    providers: [
          ChangeNotifierProvider(create: (_) => LanguageProvider()),

      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => SearchUserProvider()),
      ChangeNotifierProvider(create: (context) => CoursPlanProvider()),
      ChangeNotifierProvider(create: (context) => CoursProvider()),
      ChangeNotifierProvider(create: (context) => TabBarProvider()),
      ChangeNotifierProvider(create: (context) => NumberEntryProvider()),
      ChangeNotifierProvider(create: (context) => SectionProvider()),
      ChangeNotifierProvider(create: (context) => LeconProvider()),
    ],
    child: MultiBlocProvider(
      // Ajoutez vos Blocs/Cubits ici
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        // BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    _initializeLanguage();
  }

  Future<void> _initializeLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? globalLanguage = prefs.getInt("globalLanguage");

    if (globalLanguage == null) {
      await prefs.setInt("globalLanguage", 0);
      globalLanguage = 0;
    }

    // Assurez-vous que le widget est monté avant de changer l'état
    if (mounted) {
      Provider.of<LanguageProvider>(context, listen: false)
          .setLanguage(globalLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
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
              locale: languageProvider.language == 0
                ? const Locale('en')
                : const Locale('fr'),
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
              theme: ThemeData(fontFamily: "WorkSans"),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (setting) => generateRoute(setting),
              home: const SplashScreen());
        },
      );
    });
  }
}

// Provider.of<UserProvider>(context).user.token.isNotEmpty
//           ? Provider.of<UserProvider>(context).user.role == "1"
//               ? BottomBar()
//               : Panel()
//           : AuthScreen(),
