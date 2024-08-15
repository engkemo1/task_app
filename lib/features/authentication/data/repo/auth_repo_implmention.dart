import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/core/database/local/cache_helper.dart';
import 'package:task/core/database/local/secure_storage.dart';
import 'package:task/core/database/network/dio-helper.dart';
import 'package:task/core/database/network/dio_exceptions.dart';
import 'package:task/features/authentication/data/model/login_model.dart';
import 'package:task/features/authentication/data/repo/auth_repo.dart';
import '../../../../core/database/network/end_points.dart';

class AuthRepoImplementation extends AuthRepo {
  final SecureStorageService secureStorageService = SecureStorageService();

  @override
  Future<Either<Failure, UserModel>> login(String mobile, String password) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.login,
        data: {"mobile": mobile, "password": password},
      );

      print("Login Repo: API call successful - Response: $response");

      UserModel user = UserModel.fromJson(response.data);
      // Cache school ID
      CacheHelper.put(key: "schoolId", value: user.user!.schoolId);
      // Save token securely
      await secureStorageService.writeSecureData("token", user.token!);

      return Right(user);
    } catch (e) {
      print("Login Repo: API call failed - Error: $e");
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        print("status-code: $statusCode - response: $responseData ");
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
