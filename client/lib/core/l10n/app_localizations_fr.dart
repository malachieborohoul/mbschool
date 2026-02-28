// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'MBSchool';

  @override
  String get lbl_welcome => 'Bienvenue';

  @override
  String get lbl_log_in => 'Se connecter';

  @override
  String get lbl_sign_up => 'S\'inscrire';

  @override
  String get lbl_email_address => 'Adresse Email';

  @override
  String get lbl_password => 'Mot de passe';

  @override
  String get lbl_first_name => 'Prénom';

  @override
  String get lbl_last_name => 'Nom';

  @override
  String get msg_forgot_password => 'Mot de passe oublié ?';

  @override
  String get msg_by_submitting => 'En soumettant, j\'accepte les';

  @override
  String get msg_terms_conditions => 'Conditions Générales';

  @override
  String get phone_ipt_invalidNum => 'Numéro de téléphone invalide';

  @override
  String get phone_ipt_searchText => 'Rechercher un pays';

  @override
  String get lbl_loading => 'Chargement...';

  @override
  String get lbl_logout => 'Se déconnecter';

  @override
  String get lbl_profile => 'Profil';

  @override
  String get lbl_favorites => 'Favoris';

  @override
  String get lbl_settings => 'Paramètres';

  @override
  String get lbl_no_favorites => 'Aucun favori trouvé';

  @override
  String get lbl_course_details => 'Détails du cours';

  @override
  String get msg_are_you_sure_you_want_to_logout =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get lbl_yes_logout => 'Oui, se déconnecter';

  @override
  String get lbl_cancel => 'Annuler';

  @override
  String get lbl_oops_something_went_wrong =>
      'Oups ! Quelque chose a mal tourné.';

  @override
  String get lbl_please_try_again => 'Veuillez réessayer.';

  @override
  String get lbl_try_again => 'Réessayer';

  @override
  String get err_field_required => 'Ce champ est requis';

  @override
  String get err_invalid_name => 'Veuillez entrer un nom valide';

  @override
  String get err_invalid_email => 'Veuillez entrer une adresse email valide';

  @override
  String get err_password_short =>
      'Le mot de passe doit comporter au moins 8 caractères';
}
