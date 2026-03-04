// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// String formatDateTime(DateTime dateTime, BuildContext context) {
//     // var appLocalization = AppLocalizations.of(context);

//   final now = DateTime.now();
//   final localDateTime = dateTime.toLocal(); // Convertir en fuseau horaire local
//   final difference = now.difference(localDateTime);

//   if (difference.inSeconds < 60) {
//     // Moins d'une minute
//     return "À l'instant";
//   } else if (difference.inMinutes < 60) {
//     // Moins d'une heure
//     final minutes = difference.inMinutes;
//     return "$minutes minute${minutes > 1 ? 's' : ''}";
//   } else if (difference.inHours < 24) {
//     // Moins d'un jour
//     final hours = difference.inHours;
//     return "$hours ${appLocalization!.lbl_hour}${hours > 1 ? 's' : ''}";
//   } else if (difference.inDays < 7) {
//     // Moins d'une semaine
//     final days = difference.inDays;
//     return "$days ${appLocalization!.lbl_day}${days > 1 ? 's' : ''}";
//   } else {
//     // Plus d'une semaine, afficher la date complète
//     return DateFormat('dd MMM yyyy').format(localDateTime);
//   }
// }