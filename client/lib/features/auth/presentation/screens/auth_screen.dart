import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/core/common/animations/opacity_tween.dart';
import 'package:mbschool/core/common/animations/slide_down_tween.dart';
import 'package:mbschool/core/common/animations/slide_transition_page.dart';
import 'package:mbschool/core/common/widgets/custom_button_box.dart';
import 'package:mbschool/core/common/widgets/custom_heading.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:mbschool/core/constants/padding.dart';
import 'package:mbschool/core/constants/utils.dart';
import 'package:mbschool/core/l10n/app_localizations.dart';
import 'package:mbschool/core/utils/loader_dialog.dart';
import 'package:mbschool/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mbschool/features/auth/presentation/screens/home_screen_test.dart';
import 'package:mbschool/features/auth/presentation/screens/verification_screen.dart';
import 'package:mbschool/features/auth/presentation/widgets/build_text_field.dart';

enum Auth { signUp, login }

class AuthScreen extends StatefulWidget {
  static PageRouteBuilder<dynamic> route() =>
      PageRouteBuilder(pageBuilder: (_, animation, __) {
        return SlideTransitionPage(
          page: const AuthScreen(),
          animation: animation,
        );
      });
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Keys & State
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  // Notifiers
  final ValueNotifier<bool> allFieldsFilled = ValueNotifier<bool>(false);
  final ValueNotifier<bool> loginFieldsFilled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    nameController.addListener(_checkSignUpFields);
    prenomController.addListener(_checkSignUpFields);
    emailController.addListener(_checkAllFields);
    passwordController.addListener(_checkAllFields);
  }

  void _checkSignUpFields() => _checkAllFields();

  void _checkAllFields() {
    allFieldsFilled.value = nameController.text.isNotEmpty &&
        prenomController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    loginFieldsFilled.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    nameController.dispose();
    prenomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    allFieldsFilled.dispose();
    loginFieldsFilled.dispose();
    super.dispose();
  }

  // Common Bloc Listener Logic
  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      showLoaderDialog(context);
    } else {
      closeLoaderDialog(context);
      if (state is AuthSuccess) {
        debugPrint("💡 Auth Success");
        Navigator.pushReplacement(context, HomeScreenTest.route());
      } else if (state is AuthNotVeried) {
        debugPrint(
            "💡 Auth Not Verified - Navigating to CodeVerificationTestScreen");
        Navigator.pushReplacement(context, VerificationScreen.route());
      } else if (state is AuthFailure) {
        showSnackBar(context, state.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const Scaffold();

    // The Secret to the Status Bar visibility:
    final double topPadding = MediaQuery.of(context).viewPadding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, // Ensures clock/battery are visible
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: background,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: topPadding + appPadding, // Dynamic top spacing
                left: appPadding,
                right: appPadding,
                bottom: appPadding,
              ),
              child: _auth == Auth.signUp
                  ? _buildSignUpView(l10n)
                  : _buildLoginView(l10n),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpView(AppLocalizations l10n) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _onAuthStateChanged,
      child: Form(
        key: _signUpFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OpacityTween(
              begin: 0.0,
              child: CustomHeading(
                  title: l10n.lbl_sign_up_here,
                  subTitle: l10n.lbl_welcome_back,
                  color: secondary),
            ),
            const SizedBox(height: spacer),
            buildTextField(
                l10n.lbl_last_name, "user_icon.svg", nameController, 1),
            buildTextField(
                l10n.lbl_first_name, "user_icon.svg", prenomController, 2),
            buildTextField(
                l10n.lbl_email_address, "email_icon.svg", emailController, 3,
                type: TextInputType.emailAddress),
            buildTextField(
                l10n.lbl_password, "key_icon.svg", passwordController, 4,
                isPass: true),
            const SizedBox(height: spacer),
            ValueListenableBuilder<bool>(
              valueListenable: allFieldsFilled,
              builder: (context, isFilled, _) => GestureDetector(
                onTap: isFilled
                    ? () {
                        if (_signUpFormKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignUp(
                                context: context,
                                name: nameController.text,
                                prenom: prenomController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                        }
                      }
                    : null,
                child: CustomButtonBox(
                  title: l10n.lbl_sign_up,
                  color: isFilled ? primary : gray,
                  textColor: isFilled ? textWhite : grey,
                ),
              ),
            ),
            const SizedBox(height: spacer),
            _buildToggleAuth(l10n.lbl_already_have_an_account,
                l10n.lbl_log_in_here, Auth.login),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginView(AppLocalizations l10n) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _onAuthStateChanged,
      child: Form(
        key: _signInFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideDownTween(
              offset: 10,
              child: Center(
                  child: SvgPicture.asset("${assetImg}login_image.svg",
                      width: 200)),
            ),
            const SizedBox(height: spacer),
            CustomHeading(
                title: l10n.lbl_log_in,
                subTitle: l10n.lbl_welcome_back,
                color: secondary),
            const SizedBox(height: spacer),
            buildTextField(
                l10n.lbl_email_address, "email_icon.svg", emailController, 3),
            buildTextField(
                l10n.lbl_password, "key_icon.svg", passwordController, 4,
                isPass: true),
            const SizedBox(height: spacer),
            ValueListenableBuilder<bool>(
              valueListenable: loginFieldsFilled,
              builder: (context, isFilled, _) => GestureDetector(
                onTap: isFilled
                    ? () {
                        if (_signInFormKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignIn(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                        }
                      }
                    : null,
                child: CustomButtonBox(
                  title: l10n.lbl_log_in,
                  color: isFilled ? primary : gray,
                ),
              ),
            ),
            const SizedBox(height: spacer),
            _buildToggleAuth(
                l10n.lbl_no_account_yet, l10n.lbl_sign_up_here, Auth.signUp),
          ],
        ),
      ),
    );
  }

  // Helper UI Widgets to keep code clean

  Widget _buildToggleAuth(String msg, String action, Auth target) {
    return Row(
      children: [
        Text(msg, style: TextStyle(color: secondary.withValues(alpha: 0.5))),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => setState(() => _auth = target),
          child: Text(action,
              style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
