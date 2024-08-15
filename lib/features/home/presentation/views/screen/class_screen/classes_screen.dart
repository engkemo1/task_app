import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/components/custom_drawer.dart';
import 'package:task/core/components/custom_text_field.dart';
import 'package:task/core/utils/routes.dart';
import 'package:task/features/home/data/model/grades_model.dart';
import 'package:task/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:task/features/home/presentation/home_cubit/home_state.dart';
import 'package:task/features/home/presentation/views/widgets/update_class_dialog.dart';

class ClassesScreen extends StatefulWidget {
  final GradesModel gradesModel;

  ClassesScreen({super.key, required this.gradesModel});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Classes",
          hasIconBack: true,
          actionText: "Add Classes",
          iconData: Icons.add,
          onTapAction: () {
            // Navigate to the Add Class screen, passing the grade ID
            context.push(Routes.kAddClass, extra: widget.gradesModel.id);
          },
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          builder: (context, state) {
            // Display loading indicator if classes are being loaded
            if (state is GetClassesLoadingState) {
              SmartDialog.showLoading();
            }

            // Get the list of classes
            var allClasses = HomeCubit.get(context).allClasses;
            var filteredClasses = HomeCubit.get(context).filteredClasses;

            // Determine which list to display: all classes or filtered classes
            var displayedClasses = filteredClasses.isEmpty && searchController.text.isEmpty
                ? allClasses
                : filteredClasses;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: searchController,
                    onChanged: (searchTerm) {
                      // Filter classes based on search input
                      HomeCubit.get(context).searchClasses(searchTerm);
                      setState(() {}); // Refresh UI to reflect filtered data
                    },
                    hintText: "Search Grades",
                    prefixIcon: const Icon(Icons.search),
                  ),
                  const SizedBox(height: 20),

                  // Display the list of classes
                  ...List.generate(displayedClasses.length, (index) {
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
                                  displayedClasses[index].name!,
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
                                    // Show dialog to update the class
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return UpdateClassDialog(
                                          classesModel: displayedClasses[index],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Delete the selected class
                                    HomeCubit.get(context).deleteClasses(displayedClasses[index].id!);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                                  onPressed: () {
                                    // Handle navigation or action for this class
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
            if (state is GetClassesLoadingState) {
              SmartDialog.showLoading();
            }
            if (state is GetClassesFailureState) {
              SmartDialog.dismiss();
            }
            if (state is GetClassesSuccessState) {
              SmartDialog.dismiss();
            }
          },
        ),
      ),
    );
  }
}
