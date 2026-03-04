// import 'package:flutter/material.dart';
// import 'package:wenzo/core/theme/theme_helper.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// class AuthNavigationText extends StatelessWidget {
//   final bool isLogin; // Détermine si on affiche "Déjà un compte ?" ou "Pas encore inscrit ?"
//   final VoidCallback onTap;

//   const AuthNavigationText({
//     Key? key,
//     required this.isLogin,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final appLocalization = AppLocalizations.of(context);

//     return Wrap(
//       alignment: WrapAlignment.start,
//       spacing: 4,
//       runSpacing: 4,
//       children: [
//         Text(
//           isLogin
//               ? appLocalization!.lbl_already_have_account
//               : appLocalization!.lbl_dont_have_account,
//           style: Theme.of(context).textTheme.bodyLarge,
//         ),
//         GestureDetector(
//           onTap: onTap,
//           child: Text(
//             isLogin ? appLocalization.lbl_log_in : appLocalization.lbl_sign_up,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   color: ColorSchemes.primaryColorScheme.primary,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ),
//       ],
//     );
//   }
// }
