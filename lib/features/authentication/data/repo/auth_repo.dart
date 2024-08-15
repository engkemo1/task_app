import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:task/features/authentication/data/model/login_model.dart';

import '../../../../core/database/network/dio_exceptions.dart';

abstract class AuthRepo{


  Future<Either<Failure, UserModel>> login(
      String mobile,
      String password,
      );
}