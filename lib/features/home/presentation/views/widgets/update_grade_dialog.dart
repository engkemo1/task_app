import 'package:flutter/material.dart';
import 'package:task/core/components/custom_button.dart';
import 'package:task/core/components/custom_text_field.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/validators.dart';
import 'package:task/core/database/local/cache_helper.dart';
import 'package:task/features/home/presentation/home_cubit/home_cubit.dart';

import '../../../data/model/grades_model.dart';

class UpdateGradeDialog extends StatelessWidget {
  final GradesModel gradesModel;
  UpdateGradeDialog({super.key, required this.gradesModel});

  final TextEditingController gradeNameArController = TextEditingController();
  final TextEditingController gradeNameEnController = TextEditingController();
final GlobalKey<FormState> _form=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              CustomTextField(
                controller: gradeNameArController..text=gradesModel.nameAr!,
                validator: (value)=>Validators.validate(value, context),
                labelText: "Grade name in arabic",
                hintText: "الصف الأول",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                validator: (value)=>Validators.validate(value, context),
                controller: gradeNameEnController..text=gradesModel.nameEn!,
                labelText: "Grade name in english",
                hintText: "Primary One",
              ),
              const SizedBox(height: 30),
               CustomButton(
                onTap: ()async{
                  print(CacheHelper.get(key: "schoolId"));

                  if(_form.currentState!.validate()){
                    gradesModel.nameEn=gradeNameEnController.text;
                    gradesModel.nameAr=gradeNameArController.text;
                    Navigator.pop(context);
                    HomeCubit.get(context).updateGrades( gradesModel.id!,gradesModel);

                  }
                },
                text: "Update Grades",
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
