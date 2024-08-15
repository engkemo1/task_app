import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/core/database/local/cache_helper.dart';
import 'package:task/core/database/network/dio_exceptions.dart';
import 'package:task/features/home/data/model/grades_model.dart';
import 'package:task/features/home/data/model/classes_model.dart';
import '../../../../core/database/local/secure_storage.dart';
import '../../../../core/database/network/dio-helper.dart';
import '../../../../core/database/network/end_points.dart';
import 'home_repo.dart';

class HomeRepoImplementation extends HomeRepo {
  final SecureStorageService secureStorageService = SecureStorageService();

  @override
  Future<Either<Failure, List<GradesModel>>> getGrades() async {
    try {
      var response = await DioHelper.getData(
        url: EndPoints.grades,
        token: await secureStorageService.readSecureData("token"),
      );

      List<GradesModel> grades =
      (response.data as List).map((e) => GradesModel.fromJson(e)).toList();

      return Right(grades);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> deleteGrade(String id) async {
    try {
      final response = await DioHelper.deleteData(
        url: "${EndPoints.grades}/$id",
        token: await secureStorageService.readSecureData("token"),
      );

      return Right(response.data["message"]);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, GradesModel>> updateGrades(
      String id, GradesModel gradesModel) async {
    try {
      final response = await DioHelper.putData(
        data: gradesModel.toJson(),
        url: "${EndPoints.grades}/$id",
        token: await secureStorageService.readSecureData("token"),
      );

      GradesModel grade = GradesModel.fromJson(response.data);
      return Right(grade);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, GradesModel>> addGrade(
      String nameAr, String nameEn) async {
    try {
      final response = await DioHelper.postData(
        data: {
          "school_id": CacheHelper.get(key: "schoolId"),
          "name_ar": nameAr,
          "name_en": nameEn,
        },
        url: EndPoints.grades,
        token: await secureStorageService.readSecureData("token"),
      );

      GradesModel grade = GradesModel.fromJson(response.data);
      return Right(grade);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<ClassesModel>>> getClasses() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.classes,
        token: await secureStorageService.readSecureData("token"),
      );

      List<ClassesModel> classes =
      (response.data as List).map((e) => ClassesModel.fromJson(e)).toList();

      return Right(classes);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> deleteClasses(String id) async {
    try {
      final response = await DioHelper.deleteData(
        url: "${EndPoints.classes}/$id",
        token: await secureStorageService.readSecureData("token"),
      );

      return Right(response.data["message"]);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ClassesModel>> updateClasses(
      String id, ClassesModel classesModel) async {
    try {
      final response = await DioHelper.putData(
        data: classesModel.toJson(),
        url: "${EndPoints.classes}/$id",
        token: await secureStorageService.readSecureData("token"),
      );

      ClassesModel classes = ClassesModel.fromJson(response.data);
      return Right(classes);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ClassesModel>> addClasses(
      String nameAr, String nameEn, String gradeId) async {
    try {
      final response = await DioHelper.postData(
        data: {
          "school_id": CacheHelper.get(key: "schoolId"),
          "grade_id": gradeId,
          "name_ar": nameAr,
          "name_en": nameEn,
        },
        url: EndPoints.classes,
        token: await secureStorageService.readSecureData("token"),
      );

      ClassesModel classes = ClassesModel.fromJson(response.data);
      return Right(classes);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
