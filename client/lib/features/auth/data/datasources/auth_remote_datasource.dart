import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:mbschool/core/error/error_handler.dart';
import 'package:mbschool/core/error/exceptions.dart';
import 'package:mbschool/core/secrets/app_secrets.dart';
import 'package:mbschool/core/utils/pref_utils.dart';
import 'package:mbschool/core/utils/validation_functions.dart';
import 'package:mbschool/features/auth/data/models/auth_token_model.dart';
import 'package:mbschool/features/auth/data/models/user_model.dart';
import 'package:mbschool/features/auth/domain/entities/auth_token.dart';

abstract interface class AuthRemoteDataSource {
  String? accessToken;

  Future<UserModel> init();

  Future<UserModel> signIn({
    required String email,
    required String password,
  });
  Future<UserModel> signUp({
    required String name,
    required String prenom,
    required String email,
    required String password,
  });

  Future<UserModel> getCurrentUserApi();

  Future<List<UserModel>> getUsers();

  Future<bool> refreshToken();
  Future<bool> signOut();

  Future<String?> getAccessToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FlutterSecureStorage secureStorage;
  // final GoogleSignIn googleSignIn;

  // AuthRemoteDataSourceImpl(this.supabaseClient, this.googleSignIn);
  AuthRemoteDataSourceImpl(
    this.secureStorage,
  );

  @override
  String? accessToken;

  Future<void> clearSecureStorageIfNewInstall() async {
    try {
      final isIntro = await PrefUtils.getIntro();

      if (isIntro) {
        await secureStorage
            .deleteAll(); // Supprime toutes les données sécurisées
        await PrefUtils.setIntro(
            false); // Marque l'application comme initialisée
      }

      debugPrint("💡 From clearSecureStorageIfNewInstall - isIntro: $isIntro");
    } catch (e) {
      debugPrint("💡 Error in clearSecureStorageIfNewInstall: $e");
    }
  }

  @override
  Future<UserModel> init() async {
    return errorHandler(() async {
      await clearSecureStorageIfNewInstall();

      //Fetch for refresh token
      final secureRefreshToken =
          await secureStorage.read(key: AppSecrets.REFRESH_TOKEN_KEY);

      // debugPrint(
      //     "💡From Authremote init - secureRefreshToken $secureRefreshToken  ");

      //Check if it's for the first time
      if (secureRefreshToken == null) {
        debugPrint(
            "💡 From AuthRemoteDataSourceImpl-init secureRefreshToken=$secureRefreshToken");
        return UserModel.empty();
      }

      debugPrint("💡 From AuthRemoteDataSourceImpl-init refresh token");

      http.Response response = await http.post(
          Uri.parse(
            '${AppSecrets.baseUrl}/auth/token-refresh',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "refreshToken": secureRefreshToken,
          }));
      // Parse the body once here
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        debugPrint(
            "💡From AuthRemoteDataSource refreshToken -  ${response.body} ");
        final result = AuthTokenModel.fromMap(responseBody['data']);
        //Set local variables
        final res = await _setLocalVariables(result);

        if (res == true) {
          final user = await getCurrentUser(result);

          return user;
        }
        throw ServerException(
          message: responseBody['message'] ?? 'Erreur inconnue',
          statusCode: response.statusCode.toString(),
          code: responseBody['code'] ?? 'SERVER_ERROR',
        );
      } else {
        debugPrint("💡From AuthRemoteDataSource init -  ${response.body} ");
        throw ServerException(
          message: responseBody['message'] ?? 'Erreur inconnue',
          statusCode: response.statusCode.toString(),
          code: responseBody['code'] ?? 'SERVER_ERROR',
        );

        // throw ServerException('Error: ${res.statusCode} - ${res.reasonPhrase}');
      }
    });
  }

  Future<UserModel> getCurrentUser(AuthToken result) async {
    http.Response? response;
    try {
      Map<String, String> headers = {
        'x-auth-token': '${result.accessToken}',
        'Content-Type': 'application/json',
      };

      response = await http.get(
          Uri.parse('${AppSecrets.baseUrl}/auth/user-data'),
          headers: headers);

      debugPrint("💡 From Authremote getCurrentUser: ${response.body}");

      debugPrint("💡From Authremote getCurrentUser -  ${response.body}");

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        debugPrint("💡 User data fetched successfully");
        // Accessing responseBody['data'] as per your sendResponse helper
        return UserModel.fromMap(responseBody['data']);
      } else {
        throw ServerException(
          message: responseBody['message'] ?? "Utilisateur introuvable",
          statusCode: response.statusCode.toString(),
          code: responseBody['code'] ?? "USER_NOT_FOUND",
        );
      }
    } catch (e) {
      debugPrint("💡From Authremote getCurrentUser - error $e  ");

      throw ServerException(
        message: e.toString(),
        statusCode: response?.statusCode.toString() ?? '500',
        code: 'CONNECTION_ERROR',
      );
    }
  }

  @override
  Future<UserModel> getCurrentUserApi() async {
    http.Response? res;
    try {
      res = await http.get(Uri.parse('${AppSecrets.baseUrl}/user-data'));

      debugPrint("💡From Authremote getCurrentUserApi -  ${res.body}");

      return UserModel.fromJson(res.body);
    } catch (e) {
      debugPrint("💡From Authremote getCurrentUserApi - error $e  ");

      throw ServerException(
        message: e.toString(),
        statusCode: res?.statusCode.toString() ?? '500',
        code: 'CONNECTION_ERROR',
      );
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    http.Response? res;
    return errorHandler(() async {
      final token = await getAccessToken();
      debugPrint("💡From getUsers $token");

      // Gestion d'erreur si le token ne peut pas être récupéré
      if (token == null) {
        throw ServerException(
          message: "User is not authenticated",
        );
      }

      Map<String, String> authHeaders = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      res = await http.get(Uri.parse('${AppSecrets.baseUrl}/users'),
          headers: authHeaders);

      if (res!.statusCode == 401) {
        final refreshed = await refreshToken();

        if (!refreshed) {
          debugPrint("💡From Authremote getUsers -  $refreshed==false ");

          throw ServerException(
              message: "User is not authenticated",
              statusCode: res!.statusCode.toString());
        }

        // Récupérer le nouveau token après rafraîchissement
        final newToken = await getAccessToken();
        if (newToken == null) {
          throw ServerException(message: "User is not authenticated");
        }

        // Mise à jour du header avec le nouveau token
        authHeaders['Authorization'] = 'Bearer $newToken';

        // Relancer la requête avec le nouveau token
        res = await http.get(Uri.parse('${AppSecrets.baseUrl}/users'),
            headers: authHeaders);
      }
      if (res!.statusCode == 200) {
        final List<dynamic> usersJson = json.decode(res!.body);

        final users = usersJson
            .map((user) => UserModel.fromMap(user as Map<String, dynamic>))
            .toList();

        debugPrint("💡From Authremote getUsers -  $users ");

        return users;
      } else {
        throw ServerException(
            message: 'Ooopsss!', statusCode: res!.statusCode.toString());
      }
    });
  }

  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    http.Response? response;

    return errorHandler(() async {
      debugPrint("💡From AuthRemoteDataSource email -  $email ");
      debugPrint("💡From AuthRemoteDataSource password -  $password ");

      response = await http.post(
          Uri.parse(
            '${AppSecrets.baseUrl}/auth/signin',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"email": email, "password": password}));

      // Decode the response body once
      final Map<String, dynamic> responseBody = jsonDecode(response!.body);

      if (response!.statusCode == 200) {
        debugPrint("💡From AuthRemoteDataSource signIn -  ${response!.body} ");
        final result = AuthTokenModel.fromMap(responseBody['data']);
        // Save tokens to local storage
        final res = await _setLocalVariables(result);

        if (res == true) {
          // Return user from the 'data' field
          return UserModel.fromMap(responseBody['data']);
        }

        throw ServerException(
            message: "Impossible de sauvegarder les données locales");
      } else {
        debugPrint(
            "💡From AuthRemoteDataSource signIn -  ${response!.statusCode} ");

        // FIX 3: Deserialization for ServerException
        // We extract the standardized fields from your Node.js sendResponse helper
        throw ServerException(
          message: responseBody['message'] ?? "Erreur d'authentification",
          statusCode: response!.statusCode.toString(),
          code: responseBody['code'] ?? "AUTH_ERROR",
        );

        // throw ServerException('Error: ${res.statusCode} - ${res.reasonPhrase}');
      }
    });
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String prenom,
    required String email,
    required String password,
  }) async {
    http.Response? response;

    return errorHandler(() async {
      response = await http.post(
          Uri.parse(
            '${AppSecrets.baseUrl}/auth/signup',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "name": name,
            "prenom": prenom,
            "email": email,
            "password": password
          }));

      final Map<String, dynamic> responseBody = jsonDecode(response!.body);


      if (response!.statusCode == 200) {
        debugPrint("💡From AuthRemoteDataSource signUp -  ${response!.body} ");
        // final result = AuthTokenModel.fromJson(response.body);
        // //Set local variables
        // final res = await _setLocalVariables(result);

        // Map<String, String> headers = {
        //   'Authorization': 'Bearer ${result.accessToken}',
        //   'Content-Type': 'application/json',
        // };

        // if (res == true) {
        //   http.Response res = await http.get(
        //       Uri.parse('${AppSecrets.baseUrl}/auth/connectedUser'),
        //       headers: headers);

        //   debugPrint("💡From Authremote getCurrentUserApi -  ${res.body}");

        //   return UserModel.fromJson(res.body);
        // }

        // throw ServerException('Failed to signUp');
        return UserModel.empty();
      } else {
        debugPrint(
            "💡From AuthRemoteDataSource signUp -  ${response!.statusCode} ");

        throw ServerException(
            message: response!.body,
            statusCode: response!.statusCode.toString());

        // throw ServerException('Error: ${res.statusCode} - ${res.reasonPhrase}');
      }
    });
  }

  void printTokenParts(String token) {
    final parts = token.split('.');
    if (parts.length == 3) {
      if (kDebugMode) {
        print("Header: ${parts[0]}");
      }
      if (kDebugMode) {
        print("Payload: ${parts[1]}");
      }
      if (kDebugMode) {
        print("Signature: ${parts[2]}");
      }
    } else {
      if (kDebugMode) {
        print("Invalid JWT format.");
      }
    }
  }

  Future<bool> _setLocalVariables(AuthTokenModel result) async {
    if (isAuthTokenValid(result)) {
      accessToken = result.accessToken;

      // debugPrint("💡From Authremote accessToken -  ${result.accessToken}  ");

      if (kDebugMode) {
        print(result.accessToken);
      }

      //Store refresh token
      await secureStorage.write(
          key: AppSecrets.REFRESH_TOKEN_KEY, value: result.refreshToken);

      await secureStorage.write(
          key: AppSecrets.ACCESS_TOKEN_KEY, value: accessToken);

      // debugPrint("💡From Authremote signInOID -  $idToken  ");

      return true;
    }

    return false;
  }

  @override
  Future<String?> getAccessToken() async {
    if (accessToken != null) {
      return accessToken;
    }

    // Retrieve from secure storage
    final storedAccessToken =
        await secureStorage.read(key: AppSecrets.ACCESS_TOKEN_KEY);
    debugPrint(
        "💡From AuthRemote getAccessToken - Retrieved: $storedAccessToken");

    accessToken = storedAccessToken;
    return accessToken;
  }

  @override
  Future<bool> refreshToken() async {
    return errorHandler(() async {
      http.Response response;
      final refreshToken =
          await secureStorage.read(key: AppSecrets.REFRESH_TOKEN_KEY);

      if (refreshToken == null) {
        return false;
      }

      // final response = await appAuth.token(
      //   TokenRequest(AppSecrets.AUTH0_CLIENT_ID, AppSecrets.AUTH0_REDIRECT_URI,
      //       issuer: AppSecrets.AUTH0_ISSUER, refreshToken: refreshToken),
      // );

      response = await http.post(
          Uri.parse(
            '${AppSecrets.baseUrl}/auth/refresh',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "refreshToken": refreshToken,
          }));

      if (response.statusCode == 200) {
        debugPrint(
            "💡From AuthRemoteDataSource refreshToken -  ${response.body} ");
        final result = AuthTokenModel.fromJson(response.body);
        //Set local variables
        return await _setLocalVariables(result);
      } else {
        throw ServerException(
            message: 'Ooopsss!',
            statusCode: response.statusCode.toString(),
            code: response.body);

        // throw ServerException('Error: ${res.statusCode} - ${res.reasonPhrase}');
      }
    });
  }

  @override
  Future<bool> signOut() async {
    return errorHandler(() async {
      final refreshToken =
          await secureStorage.read(key: AppSecrets.REFRESH_TOKEN_KEY);

      if (refreshToken == null) {
        return false;
      }

      await secureStorage.delete(key: AppSecrets.REFRESH_TOKEN_KEY);

      return true;

      // final response = await appAuth.token(
      //   TokenRequest(AppSecrets.AUTH0_CLIENT_ID, AppSecrets.AUTH0_REDIRECT_URI,
      //       issuer: AppSecrets.AUTH0_ISSUER, refreshToken: refreshToken),
      // );

      // http.Response response = await http.post(
      //     Uri.parse(
      //       '${AppSecrets.baseUrl}/auth/logout',
      //     ),
      //     headers: {
      //       'Content-Type': 'application/json',
      //     },
      //     body: jsonEncode({
      //       "refreshToken": refreshToken,
      //     }));

      // if (response.statusCode == 200) {
      //   debugPrint("💡From AuthRemoteDataSource signOut -  ${response.body} ");

      //   await secureStorage.delete(key: AppSecrets.REFRESH_TOKEN_KEY);

      //   return true;
      // } else {
      //   debugPrint(
      //       "💡From AuthRemoteDataSource signOut -  ${response.body} ${response.statusCode.toString()} ");
      //   throw ServerException(
      //     message: response.body,
      //     statusCode: response.statusCode.toString(),
      //     code: 'CONNECTION_ERROR',
      //   );

      //   // throw ServerException('Error: ${res.statusCode} - ${res.reasonPhrase}');
      // }
    });
  }
}
