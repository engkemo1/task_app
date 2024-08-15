import 'package:flutter/material.dart';
import 'package:task/core/components/custom_button.dart';
import 'package:task/core/components/custom_text_field.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/validators.dart';
import 'package:task/features/home/data/model/classes_model.dart';
import 'package:task/features/home/presentation/home_cubit/home_cubit.dart';

class UpdateClassDialog extends StatelessWidget {
  final ClassesModel classesModel;

  // Controllers for text fields
  final TextEditingController classNameArController = TextEditingController();
  final TextEditingController classNameEnController = TextEditingController();

  // Form key to manage form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UpdateClassDialog({super.key, required this.classesModel}) {
    // Initialize text controllers with existing class data
    classNameArController.text = classesModel.nameAr!;
    classNameEnController.text = classesModel.nameEn!;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),

              // Text field for class name in Arabic
              CustomTextField(
                controller: classNameArController,
                validator: (value) => Validators.validate(value, context),
                labelText: "Class name in Arabic",
                hintText: "الفصل الأول",
              ),
              const SizedBox(height: 10),

              // Text field for class name in English
              CustomTextField(
                controller: classNameEnController,
                validator: (value) => Validators.validate(value, context),
                labelText: "Class name in English",
                hintText: "Class One",
              ),
              const SizedBox(height: 30),

              // Button to update the class
              CustomButton(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    // Update class model with new values
                    classesModel.nameAr = classNameArController.text;
                    classesModel.nameEn = classNameEnController.text;

                    // Close the dialog
                    Navigator.pop(context);

                    // Update class in the backend
                    HomeCubit.get(context).updateClasses(classesModel.id!, classesModel);
                  }
                },
                text: "Update Class",
                color: AppColors.primaryColor,
                raduis: 20,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
