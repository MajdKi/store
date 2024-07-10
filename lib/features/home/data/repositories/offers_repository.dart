import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:store_app/core/errors/app_exception.dart';
import 'package:store_app/features/home/data/datasources/offers_client.dart';
import 'package:store_app/features/home/data/models/offers_model.dart';

import '../../../../core/errors/error_model.dart';

class OffersRepository {
  OffersClient client = OffersClient();

  Future<Either<ErrorModel, OffersModel>> getOffers() async {
    try {
      final OffersModel remote = await client.getOffers();
      return Right(remote);
    } on AppException catch (e) {
      if (kDebugMode) {
        print('e message ${e.message}');
      }
      if (kDebugMode) {
        print('e data ${e.data}');
      }
      return Left(ErrorModel.fromException(e));
    } catch (e) {
      return Left(ErrorModel.fromException(AppException(e)));
    }
  }
}

class LoginParam extends Equatable {
  final String phone;
  final String password;
  const LoginParam({
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [phone, password];
}