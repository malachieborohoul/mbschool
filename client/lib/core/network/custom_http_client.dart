import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/core/error/exceptions.dart';
import 'package:mbschool/core/secrets/app_secrets.dart';
import 'package:mbschool/features/auth/domain/repositories/auth_repository.dart';

import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
class CustomHttpClient {
  final http.Client _client;
  final AuthRepository _authRepository;

  CustomHttpClient(this._client, this._authRepository);

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    return _sendRequest((authHeaders) =>
        _client.get(Uri.parse(url), headers: {...authHeaders, ...?headers}));
  }

  Future<http.Response> post(String url,
      {Map<String, String>? headers, Object? body}) async {
    return _sendRequest((authHeaders) => _client.post(Uri.parse(url),
        headers: {...authHeaders, ...?headers}, body: body));
  }

    Future<String> uploadKycFile(File file) async {
    var uri = Uri.parse("${AppSecrets.baseUrl}/mobile/kyc");
    var request = http.MultipartRequest("POST", uri);

    // Récupérer le token
    final tokenEither = await _authRepository.getAccessToken();
    debugPrint("💡From CustomHttpClient $tokenEither");

    final String? token = tokenEither.fold((failure) => null, (token) => token);
    if (token == null) {
      debugPrint("💡From CustomHttpClient accessToken==null");
      throw ServerException( message: "User is not authenticated");
    }

    // Ajout du fichier
    var mimeType = lookupMimeType(file.path);
    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        file.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      ),
    );

    // Ajout des headers d'authentification
    request.headers["Authorization"] = "Bearer $token";
    request.headers["Content-Type"] = "multipart/form-data";

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((val) {
          print(val);
        });

        // return value;

        return "ok";
      } else if (response.statusCode == 401) {
        // Token expiré, tentative de rafraîchissement
        final refreshEither = await _authRepository.refreshToken();
        bool refreshed = refreshEither.fold(
          (failure) {
            if (failure.statusCode == "400") return false;
            throw ServerException(message: "User is not authenticated", statusCode: failure.statusCode, code: failure.code);
          },
          (success) => success,
        );

        if (!refreshed) {
          throw ServerException(message: "", statusCode: "400", code: AppSecrets.AUTH_INVALID_CREDENTIALS);
        }

        // Récupération du nouveau token
        final newTokenEither = await _authRepository.getAccessToken();
        final String? newToken = newTokenEither.fold((failure) => null, (token) => token);

        if (newToken == null) {
          throw ServerException(message: "User is not authenticated");
        }

        // Refaire la requête avec le nouveau token
        request.headers["Authorization"] = "Bearer $newToken";
        var retryResponse = await request.send();

        if (retryResponse.statusCode == 200) {
          retryResponse.stream.transform(utf8.decoder).listen((val) {
            print(val);
          });

          return "ok";
        } else {
          throw ServerException(message: "Failed to upload KYC file. Status code: ${retryResponse.statusCode}");
        }
      }

      throw ServerException(message: "Failed to upload KYC file. Status code: ${response.statusCode}");
    } on TimeoutException catch (e) {
      throw ServerException(message: e.message ?? 'Timeout Error');
    } on FormatException catch (e) {
      throw ServerException(message: e.message);
    } on SocketException catch (e) {
      throw ServerException(message: e.message);
    } on PlatformException catch (e) {
      throw ServerException(message: e.message ?? 'Something went wrong! Code ${e.code}', statusCode: e.code, code: e.details['error']);
    } catch (e) {
      if (e is ServerException) {
        throw e;
      } else {
        throw ServerException(message: 'Unknown error ${e.runtimeType}');
      }
    }
  }

  Future<http.Response> _sendRequest(
      Future<http.Response> Function(Map<String, String>) request) async {
    final tokenEither = await _authRepository.getAccessToken();
    debugPrint("💡From CustomHttpClient $tokenEither");

    // Gestion d'erreur si le token ne peut pas être récupéré
    final String? token = tokenEither.fold((failure) => null, (token) => token);
    if (token == null) {
      debugPrint("💡From CustomHttpClient accessToken==null");

      throw ServerException(message: "User is not authenticated");
    }
    

    Map<String, String> authHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      http.Response response = await request(authHeaders);

      if (response.statusCode == 401) {
        // Token expiré, on tente de le rafraîchir
        final refreshEither = await _authRepository.refreshToken();

        bool refreshed = refreshEither.fold((failure) {
        if(failure.statusCode == "400"){

            return false;
          }
            else{
            debugPrint("💡From CustomHttpClient failure.statusCode == 401");

            throw ServerException(
                message: "User is not authenticated", statusCode: failure.statusCode, code: failure.code);
          }
        }, (success) => success);
        if (!refreshed) {
          {
            debugPrint("💡From CustomHttpClient refreshToken==false");

            throw ServerException(message: "", statusCode: "400", code: AppSecrets.AUTH_INVALID_CREDENTIALS);
          }
        }

        // Récupérer le nouveau token après rafraîchissement
        final newTokenEither = await _authRepository.getAccessToken();
        final String? newToken =
            newTokenEither.fold((failure) => null, (token) => token);
        if (newToken == null)
        {
          debugPrint("💡From CustomHttpClient accessToken==null");
          throw ServerException(message: "User is not authenticated");
        
}
        // Mise à jour du header avec le nouveau token
        authHeaders['Authorization'] = 'Bearer $newToken';

        // Relancer la requête avec le nouveau token
        response = await request(authHeaders);
      }

      return response;
    } on TimeoutException catch (e) {
      debugPrint("💡From CustomHttpClient - TimeoutException $e  ");

      throw ServerException(message: e.message ?? 'Timeout Error');
    } on FormatException catch (e) {
      debugPrint("💡From CustomHttpClient - FormatException $e  ");

      throw ServerException(message: e.message);
    } on SocketException catch (e) {
      debugPrint("💡From CustomHttpClient - SocketException $e  ");

      throw ServerException(message: e.message);
    } on PlatformException catch (e) {
      debugPrint(
          "💡From CustomHttpClient - PlatformException ${e.details['error']}  ");

      throw ServerException(message: e.message ?? 'Something went wrong! Code ${e.code}', statusCode: e.code, code: e.details['error']);
    } catch (e) {
      debugPrint("💡From CustomHttpClient - errors $e  ");

      if (e is ServerException) {
        throw ServerException(
         message:  e.message,
          statusCode: e.statusCode,
          code: e.code,
        );
      } else {
        // Si ce n'est pas une ServerException, lancez une exception générique
        throw ServerException(message: 'Unknown error ${e.runtimeType}');
      }
    }
  }
}
