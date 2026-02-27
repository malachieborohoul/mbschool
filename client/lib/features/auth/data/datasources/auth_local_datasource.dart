// // import 'package:hive/hive.dart';
// import 'package:wenzo/features/auth/data/models/user_model.dart';

// abstract interface class AuthLocalDatasource {
//   void addCachedProfil({required UserModel user});

//   UserModel? getCachedProfil();
// }

// class AuthLocalDatasourceImpl implements AuthLocalDatasource {
//   final Box box;

//   AuthLocalDatasourceImpl(this.box);
//   @override
//   void addCachedProfil({required UserModel user}) {
//     try {
//       box.clear();
//     box.write(() {
//       box.put("cachedUser", user.toMap());
//     });
//     } catch (e) {
//       throw Exception('Failed to cache user profile: $e');
//     }
//   }

//   @override
//   UserModel? getCachedProfil() {
//    try {
//      final cachedData = box.get("cachedUser");
//     if (cachedData != null) {
//         // Convertit les données en `UserModel` si elles existent
//         return UserModel.fromMap(cachedData);
//       } else {
//         return null; // Aucune donnée en cache
//       }
//    } catch (e) {
//      throw Exception('Failed to retrieve cached user profile: $e');
//    }
//   }
// }
