import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/home/data/model/classes_model.dart';
import 'package:task/features/home/data/model/grades_model.dart';
import 'package:task/features/home/data/repo/home_repo.dart';
import 'package:task/features/home/presentation/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<GradesModel> allGrades = [];
  List<GradesModel> filteredGrades = [];

  /// Fetches all grades
  Future<void> getAllGrades() async {
    emit(GetGradesLoadingState());
    var result = await homeRepo.getGrades();
    result.fold(
          (failure) {
        emit(GetGradesFailureState(failure.errorMessages));
      },
          (grades) {
        allGrades = grades;
        emit(GetGradesSuccessState(grades));
      },
    );
  }

  /// Updates a grade
  Future<void> updateGrades(String id, GradesModel gradesModel) async {
    emit(GetGradesLoadingState());
    var result = await homeRepo.updateGrades(id, gradesModel);
    result.fold(
          (failure) {
        emit(GetGradesFailureState(failure.errorMessages));
      },
          (success) {
        getAllGrades();
      },
    );
  }

  /// Deletes a grade
  Future<void> deleteGrades(String id) async {
    emit(GetGradesLoadingState());
    var result = await homeRepo.deleteGrade(id);
    result.fold(
          (failure) {
        emit(GetGradesFailureState(failure.errorMessages));
      },
          (message) {
        emit(DeleteGradesSuccessState(message));
        getAllGrades();
      },
    );
  }

  /// Searches grades based on a query
  void searchGrades(String searchQuery) {
    searchQuery = searchQuery.toLowerCase();
    filteredGrades = allGrades.where((grade) {
      return grade.name!.toLowerCase().contains(searchQuery);
    }).toList();

    if (searchQuery.isEmpty) {
      filteredGrades.clear();
    }
  }

  /// Adds a new grade
  Future<void> addGrades(String nameAr, String nameEn) async {
    emit(AddGradesLoadingState());
    var result = await homeRepo.addGrade(nameAr, nameEn);
    result.fold(
          (failure) {
        emit(AddGradesFailureState(failure.errorMessages));
      },
          (grades) {
        emit(AddGradesSuccessState(grades));
        getAllGrades();
      },
    );
  }

  ///////////////////////// Classes //////////////////////////////

  List<ClassesModel> allClasses = [];
  List<ClassesModel> filteredClasses = [];

  /// Fetches all classes
  Future<void> getAllClasses() async {
    emit(GetClassesLoadingState());
    var result = await homeRepo.getClasses();
    result.fold(
          (failure) {
        emit(GetClassesFailureState(failure.errorMessages));
      },
          (classes) {
        allClasses = classes;
        emit(GetClassesSuccessState(classes));
      },
    );
  }

  /// Updates a class
  Future<void> updateClasses(String id, ClassesModel classesModel) async {
    emit(GetClassesLoadingState());
    var result = await homeRepo.updateClasses(id, classesModel);
    result.fold(
          (failure) {
        emit(GetClassesFailureState(failure.errorMessages));
      },
          (success) {
        getAllClasses();
      },
    );
  }

  /// Deletes a class
  Future<void> deleteClasses(String id) async {
    emit(GetClassesLoadingState());
    var result = await homeRepo.deleteClasses(id);
    result.fold(
          (failure) {
        emit(GetClassesFailureState(failure.errorMessages));
      },
          (message) {
        emit(DeleteClassesSuccessState(message));
        getAllClasses();
      },
    );
  }

  /// Searches classes based on a query
  void searchClasses(String searchQuery) {
    searchQuery = searchQuery.toLowerCase();
    filteredClasses = allClasses.where((classModel) {
      return classModel.name!.toLowerCase().contains(searchQuery);
    }).toList();

    if (searchQuery.isEmpty) {
      filteredClasses.clear();
    }
  }

  /// Adds a new class
  Future<void> addClasses(String nameAr, String nameEn, String gradeId) async {
    emit(AddClassesLoadingState());
    var result = await homeRepo.addClasses(nameAr, nameEn, gradeId);
    result.fold(
          (failure) {
        emit(AddClassesFailureState(failure.errorMessages));
      },
          (classes) {
        emit(AddClassesSuccessState(classes));
        getAllClasses();
      },
    );
  }
}
