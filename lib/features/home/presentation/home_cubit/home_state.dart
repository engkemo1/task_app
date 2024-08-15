


import 'package:task/features/home/data/model/grades_model.dart';

import '../../data/model/classes_model.dart';

abstract class HomeState   {

}
class HomeInitialState extends HomeState {}

//Classes

class GetClassesLoadingState extends HomeState {}
class GetClassesFailureState extends HomeState {
  final String message;


  GetClassesFailureState(this.message);}

class GetClassesSuccessState extends HomeState {
  final List<ClassesModel> classesModel;
  GetClassesSuccessState(this.classesModel);}
class  UpdateClassesSuccessState extends HomeState {
  final ClassesModel classesModel;
  UpdateClassesSuccessState(this.classesModel);}

class  DeleteClassesSuccessState extends HomeState {
  final String message;
  DeleteClassesSuccessState(this.message);}
class AddClassesLoadingState extends HomeState {}
class AddClassesFailureState extends HomeState {
  final String message;


  AddClassesFailureState(this.message);}

class AddClassesSuccessState extends HomeState {
  final ClassesModel classesModel;
  AddClassesSuccessState(this.classesModel);}

//Grades

class GetGradesLoadingState extends HomeState {}
class GetGradesFailureState extends HomeState {
  final String message;


  GetGradesFailureState(this.message);}

class GetGradesSuccessState extends HomeState {
  final List<GradesModel> gradesModel;
  GetGradesSuccessState(this.gradesModel);}

class AddGradesLoadingState extends HomeState {}
class AddGradesFailureState extends HomeState {
  final String message;


  AddGradesFailureState(this.message);}

class AddGradesSuccessState extends HomeState {
  final GradesModel gradesModel;
  AddGradesSuccessState(this.gradesModel);}


class  UpdateGradesSuccessState extends HomeState {
  final GradesModel gradesModel;
  UpdateGradesSuccessState(this.gradesModel);}

class  DeleteGradesSuccessState extends HomeState {
  final String message;
  DeleteGradesSuccessState(this.message);}