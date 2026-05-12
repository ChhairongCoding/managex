import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockmanagement/src/core/routes/routers.dart';
import 'package:stockmanagement/src/helper/resuable.dart';

import '../bloc/index.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isPasswordVisible = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _shopNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      body: SingleChildScrollView(child: _buildBody(theme)),
    );
  }

  Widget _buildBody(ThemeData theme) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routers.appPage,
            (route) => false,
          );
        }
        if (state is RegisterError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 25,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "onboarding".toUpperCase(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                  Text(
                    "Join ManageX today",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    textFieldCustomWidget(
                      controller: _fullNameController,
                      context: context,
                      label: "Full Name",
                      hintText: "Enter Full Name...",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your full name";
                        }

                        if (value.trim().length < 3) {
                          return "Full name must be at least 3 characters";
                        }

                        return null;
                      },
                    ),
                    textFieldCustomWidget(
                      context: context,
                      label: "Shop Name",
                      hintText: "Enter Shop Name",
                      controller: _shopNameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your shop name";
                        }

                        return null;
                      },
                    ),
                    textFieldCustomWidget(
                      context: context,
                      label: "Email",
                      hintText: "store@managex.com",
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your email";
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (!emailRegex.hasMatch(value.trim())) {
                          return "Invalid email format";
                        }

                        return null;
                      },
                    ),
                    textFieldCustomWidget(
                      controller: _passwordController,
                      context: context,
                      label: "Password",
                      hintText: "********",
                      obscureText: isPasswordVisible,
                      suffixIcon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                      suffixIconPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }

                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }

                        return null;
                      },
                    ),
                    textFieldCustomWidget(
                      controller: _confirmPasswordController,
                      context: context,
                      label: "Confirm Password",
                      hintText: "********",
                      obscureText: isPasswordVisible,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm password";
                        }

                        if (value != _passwordController.text) {
                          return "Password does not match";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              context.read<RegisterBloc>().add(
                                RegisterSubmitted(
                                  fullName: _fullNameController.text.trim(),
                                  shopName: _shopNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  confirmPassword: _confirmPasswordController
                                      .text
                                      .trim(),
                                ),
                              );

                              if (state is RegisterSuccess) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routers.appPage,
                                  (route) => false,
                                );
                              }
                            },
                            child: state is RegisterLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Register",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
