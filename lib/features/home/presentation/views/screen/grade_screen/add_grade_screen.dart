import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:task/core/components/custom_button.dart';
import 'package:task/core/components/custom_text_field.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/features/home/data/model/grades_model.dart';
import 'package:task/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:task/features/home/presentation/home_cubit/home_state.dart';

import '../../../../../../core/constants/validators.dart';

class AddGradeScreen extends StatelessWidget {
  AddGradeScreen({super.key});

  final TextEditingController gradeNameArController = TextEditingController();
  final TextEditingController gradeNameEnController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    CustomTextField(
                      validator: (value) =>
                          Validators.validate(value, context),
                      controller: gradeNameArController,
                      labelText: "Grade name in Arabic",
                      hintText: "الصف الأول",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      validator: (value) =>
                          Validators.validate(value, context),
                      controller: gradeNameEnController,
                      labelText: "Grade name in English",
                      hintText: "Primary One",
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      onTap: () {
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();
                          GradesModel gradesModel = GradesModel();
                          gradesModel.nameAr = gradeNameArController.text;
                          gradesModel.nameEn = gradeNameEnController.text;
                          HomeCubit.get(context).addGrades(
                              gradesModel.nameAr!, gradesModel.nameEn!);
                        }
                      },
                      text: "Add Grades",
                      color: AppColors.primaryColor,
                      raduis: 20,
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, HomeState state) {
        if (state is AddGradesLoadingState) {
          SmartDialog.showLoading();
        } else if (state is AddGradesFailureState) {
          SmartDialog.showToast(state.message);
          SmartDialog.dismiss();
        } else if (state is AddGradesSuccessState) {
          SmartDialog.dismiss();
          _form.currentState!.reset();

          // Clear the text controllers after successful addition
          gradeNameArController.clear();
          gradeNameEnController.clear();

          SmartDialog.showToast("Added Successfully");
        }
      },
    );
  }
}
