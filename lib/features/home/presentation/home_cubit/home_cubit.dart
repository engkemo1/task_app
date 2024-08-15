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
// get grades
  Future<void> getAllGrades() async {
    emit(GetGradesLoadingState());
    var result = await homeRepo.getGrades();
    result.fold(
      (failure) {
        emit(GetGradesFailureState(failure.errorMessages));
      },
      (grades) {
        allGrades=grades;
        emit(GetGradesSuccessState(grades));
      },
    );
  }

// update grades
  Future<void> updateGrades(String id,GradesModel gradesModel) async {
    emit(GetGradesLoadingState());

    var result = await homeRepo.updateGrades(id, gradesModel);
    result.fold(
      (failure) {
        emit(GetGradesFailureState(failure.errorMessages));
        getAllGrades();

      },
      (grades) {

        getAllGrades();

      },
    );
  }

  // delete grades
  Future<void> deleteGrades(String id) async {
    emit(GetGradesLoadingState());
    var result = await homeRepo.deleteGrade(id);
    result.fold(
          (failure) {
        emit(GetGradesFailureState(failure.errorMessages));
        getAllGrades();

          },
          (message) {
            DeleteGradesSuccessState(message);
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
  // add grades
  Future<void> addGrades( String nameAr,String nameEn) async {
    emit(AddGradesLoadingState());
    var result = await homeRepo.addGrade(nameAr,nameEn);
    result.fold(
          (failure) {
        emit(AddGradesFailureState(failure.errorMessages));
        getAllGrades();

          },
          (grades) {
        emit(AddGradesSuccessState(grades));
        getAllGrades();

          },
    );
  }
/////////////////////////classes/////////////////////////////
  List<ClassesModel> allClasses = [];
  List<ClassesModel> filteredClasses = [];
  // get grades
  Future<void> getAllClasses() async {
    emit(GetClassesLoadingState());
    var result = await homeRepo.getClasses();
    result.fold(
          (failure) {
        emit(GetClassesFailureState(failure.errorMessages));
      },
          (classes) {
            allClasses=classes;
        emit(GetClassesSuccessState(classes));
      },
    );
  }

// update grades
  Future<void> updateClasses(String id,ClassesModel classesModel) async {
    var result = await homeRepo.updateClasses(id, classesModel);
    result.fold(
          (failure) {
            emit(GetClassesFailureState(failure.errorMessages));
            getAllClasses();
          },
          (classes) {
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
  // delete grades
  Future<void> deleteClasses(String id) async {
    var result = await homeRepo.deleteClasses(id);
    result.fold(
          (failure) {
            getAllClasses();
          },
          (message) {
            getAllClasses();
          },
    );
  }
  // add grades
  Future<void> addClasses(

      String nameAr,String nameEn,String gradeId) async {
    emit(AddClassesLoadingState());
    var result = await homeRepo.addClasses(nameAr,nameEn,gradeId);
    result.fold(
          (failure) {

            emit(AddClassesFailureState(failure.errorMessages));
            getAllClasses();

          },
          (classes) {

            emit(AddClassesSuccessState(classes));
            getAllClasses();

          },
    );
  }

}
