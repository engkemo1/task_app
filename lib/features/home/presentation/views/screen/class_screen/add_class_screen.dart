import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:task/core/components/custom_button.dart';
import 'package:task/core/components/custom_text_field.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/features/home/data/model/classes_model.dart';
import 'package:task/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:task/features/home/presentation/home_cubit/home_state.dart';

import '../../../../../../core/constants/validators.dart';

class AddClassScreen extends StatelessWidget {
  final String gradeId;  // Renamed for clarity

  AddClassScreen({super.key, required this.gradeId});

  // Controllers for text fields
  final TextEditingController classNameArController = TextEditingController();
  final TextEditingController classNameEnController = TextEditingController();

  // Form key to manage form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    // Text field for class name in Arabic
                    CustomTextField(
                      validator: (value) => Validators.validate(value, context),
                      controller: classNameArController,
                      labelText: "Class name in Arabic",
                      hintText: "الفصل الأول",
                    ),
                    const SizedBox(height: 10),

                    // Text field for class name in English
                    CustomTextField(
                      validator: (value) => Validators.validate(value, context),
                      controller: classNameEnController,
                      labelText: "Class name in English",
                      hintText: "Class One",
                    ),
                    const SizedBox(height: 30),

                    // Button to add the class
                    CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // Create a new class model and assign values
                          ClassesModel newClass = ClassesModel(
                            nameAr: classNameArController.text,
                            nameEn: classNameEnController.text,
                          );

                          // Add the class through the cubit
                          HomeCubit.get(context).addClasses(
                            newClass.nameAr!,
                            newClass.nameEn!,
                            gradeId,
                          );
                        }
                      },
                      text: "Add Class",
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
        if (state is AddClassesLoadingState) {
          SmartDialog.showLoading(); // Show loading indicator
        } else if (state is AddClassesFailureState) {
          SmartDialog.dismiss(); // Dismiss loading indicator
          SmartDialog.showToast(state.message); // Show error message
        } else if (state is AddClassesSuccessState) {
          SmartDialog.dismiss(); // Dismiss loading indicator
          _formKey.currentState!.reset(); // Reset the form

          // Clear text controllers after successful addition
          classNameArController.clear();
          classNameEnController.clear();

          SmartDialog.showToast("Class added successfully"); // Show success message
        }
      },
    );
  }
}
