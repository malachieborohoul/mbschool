import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbschool/core/error/exceptions.dart';

Future<T> errorHandler<T>(Future<T> Function() callback) async {
    try {
      return await callback();
    } on TimeoutException catch (e) {
      debugPrint("💡From errorHandler - TimeoutException $e  ");

      throw ServerException(message:  e.message ?? 'Timeout Error');
    } on FormatException catch (e) {
      debugPrint("💡From errorHandler - FormatException $e  ");

      throw ServerException(message: e.message);
    } on SocketException catch (e) {
      debugPrint("💡From errorHandler - SocketException $e  ");

      throw ServerException(message: e.message);
    } on PlatformException catch (e) {
      debugPrint("💡From errorHandler - PlatformException ${e.details['error']}  ");

      throw ServerException(
          message: e.message ?? 'Something went wrong! Code ${e.code}',
          code: e.code,
          statusCode: e.details?['error'] ?? "");
    } catch (e) {
      debugPrint("💡From errorHandler - errors $e  ");
      debugPrint("💡From errorHandler -  ${e is ServerException } ");

      if (e is ServerException) {
      throw ServerException(
        message: e.message,
        code: e.code,
        statusCode: e.statusCode,
      );
    } else {
      // Si ce n'est pas une ServerException, lancez une exception générique
      throw ServerException(message: 'Unknown error ${e.runtimeType}');
    }

    }
  }