import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/components/custom_drawer.dart';
import 'package:task/core/components/custom_text_field.dart';
import 'package:task/core/utils/routes.dart';
import 'package:task/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:task/features/home/presentation/home_cubit/home_state.dart';
import '../../widgets/update_grade_dialog.dart';

class GradesScreen extends StatefulWidget {
  GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Grades",
          hasIconBack: true,
          actionText: "Add Grades",
          iconData: Icons.add,
          onTapAction: () {
            context.push(Routes.kAddGrade); // Navigate to Add Grade screen
          },
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            // Display loading indicator if grades are being loaded
            if (state is GetGradesLoadingState) {
              SmartDialog.showLoading();
            }

            // Get the list of grades
            var allGrades = HomeCubit.get(context).allGrades;
            var filteredGrades = HomeCubit.get(context).filteredGrades;

            // Determine which list to display: all grades or filtered grades
            var displayedGrades = filteredGrades.isEmpty && searchController.text.isEmpty
                ? allGrades
                : filteredGrades;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: searchController,
                    onChanged: (searchTerm) {
                      // Filter grades based on search input
                      HomeCubit.get(context).searchGrades(searchTerm);
                      setState(() {}); // Refresh UI to reflect filtered data
                    },
                    hintText: "Search classes",
                    prefixIcon: const Icon(Icons.search),
                  ),
                  const SizedBox(height: 20),

                  // Display the list of grades
                  ...List.generate(displayedGrades.length, (index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FittedBox(
                              child: SizedBox(
                                width: 100,
                                child: Text(
                                  displayedGrades[index].name!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Show dialog to update the grade
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return UpdateGradeDialog(
                                          gradesModel: displayedGrades[index],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Delete the selected grade
                                    HomeCubit.get(context).deleteGrades(displayedGrades[index].id!);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                                  onPressed: () {
                                    // Navigate to class Class screen
                                    context.push(Routes.kClass, extra: displayedGrades[index]);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
          listener: (BuildContext context, HomeState state) {
            // Handle state changes
            if (state is GetGradesLoadingState) {
              SmartDialog.showLoading();
            }
            if (state is GetGradesFailureState) {
              SmartDialog.dismiss();
            }
            if (state is GetGradesSuccessState) {
              SmartDialog.dismiss();
            }
            if (state is DeleteGradesSuccessState) {
              SmartDialog.showToast(state.message);
              SmartDialog.dismiss();
            }
          },
        ),
      ),
    );
  }
}
