import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/components/custom_button.dart';
import 'package:task/core/components/custom_text_field.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/features/authentication/data/repo/auth_repo_implmention.dart';
import 'package:task/features/authentication/presentation/auth_cubit/auth_cubit.dart';
import 'package:task/features/authentication/presentation/auth_cubit/auth_state.dart';
import 'package:task/res/images_res.dart';

import '../../../../../core/constants/validators.dart';
import '../../../../../core/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller for phone number and password fields
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  // To toggle password visibility
  bool _obscurePass = true;

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(AuthRepoImplementation()),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: size.height * 0.1),

                    // Phone number input field
                    CustomTextField(
                      controller: phoneController,
                      hintText: "Enter your phone number",
                      keyboardType: TextInputType.number,
                      validator: (val) => Validators.validatePhoneNumber(val!, context),
                      prefixIcon: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Image.asset(ImagesRes.FLAG_OF_SAUDI_ARABIA, width: 35),
                            const Text(
                              " +966",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      labelText: "Mobile Number",
                    ),
                    const SizedBox(height: 20),

                    // Password input field
                    CustomTextField(
                      controller: passController,
                      hintText: "Enter your password",
                      labelText: "Password",
                      obscureText: _obscurePass,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _obscurePass = !_obscurePass;
                          });
                        },
                        child: Icon(
                          _obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        ),
                      ),
                      validator: (value) => Validators.validatePassword(value, context),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 20),

                    // Login button
                    BlocConsumer<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              AuthCubit.get(context).login(
                                phone: phoneController.text,
                                password: passController.text,
                              );
                            }
                          },
                          text: "Login",
                          color: AppColors.orangeColor,
                          width: double.infinity,
                          height: 55,
                        );
                      },
                      listener: (context, state) {
                        if (state is LoginLoadingState) {
                          SmartDialog.showLoading();
                        } else if (state is LoginFailureState) {
                          SmartDialog.dismiss();
                          SmartDialog.showToast(state.error);
                        } else if (state is LoginSuccessState) {
                          SmartDialog.dismiss();
                          context.go(Routes.kHome);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
