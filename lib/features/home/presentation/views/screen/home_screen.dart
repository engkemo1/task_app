import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/utils/app_router.dart';
import 'package:task/core/utils/routes.dart';

import '../../../../../core/components/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(),
        appBar: CustomAppBar(
          hasIconBack: false,
          title: "Home page",
          subtitle: "Head Teacher",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(Routes.kGrades);
                },
                child: Card(
                  child: SizedBox(
                    height: 70.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40, // Fixed width for leading widget
                                decoration: const BoxDecoration(
                                  color: AppColors.lightWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(Icons.grade_outlined),
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                "Grades",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
