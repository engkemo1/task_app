import 'package:dartz/dartz.dart';
import 'package:task/features/home/data/model/classes_model.dart';
import 'package:task/features/home/data/model/grades_model.dart';

import '../../../../core/database/network/dio_exceptions.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<GradesModel>>> getGrades();

  Future<Either<Failure, GradesModel>> addGrade(String nameAr, String nameEn);

  Future<Either<Failure, GradesModel>> updateGrades(
    String id,
    GradesModel gradesModel,
  );

  Future<Either<Failure, String>> deleteGrade(String id);

  Future<Either<Failure, List<ClassesModel>>> getClasses();

  Future<Either<Failure, ClassesModel>> addClasses(
      String nameAr, String nameEn, String gradeId);

  Future<Either<Failure, ClassesModel>> updateClasses(
    String id,
    ClassesModel classesModel,
  );

  Future<Either<Failure, String>> deleteClasses(String id);
}
