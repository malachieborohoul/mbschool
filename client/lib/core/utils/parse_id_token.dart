// import 'dart:convert';


// import 'package:wenzo/core/data/models/auth0_id_token_model.dart';

// Auth0IdTokenModel parseIdToken(String? idToken) {
//   final parts = idToken!.split(r'.');
//   final Map<String, dynamic> json = jsonDecode(
//     utf8.decode(
//       base64Url.decode(
//         base64Url.normalize(parts[1]),//body part
//       ),
//     ),
//   );
//       // debugPrint("💡From parseIdToken  $json  ");

//       return Auth0IdTokenModel.fromMap(json);

// }
