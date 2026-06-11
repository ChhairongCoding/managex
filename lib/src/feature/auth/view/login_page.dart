import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managex/src/core/routes/routers.dart';
import 'package:managex/src/feature/auth/bloc/login/login_bloc.dart';
import 'package:managex/src/feature/auth/bloc/login/login_event.dart';
import 'package:managex/src/feature/auth/bloc/login/login_state.dart';
import 'package:managex/src/feature/auth/repository/auth_repository.dart';
import 'package:managex/src/helper/resuable.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginBloc(AuthRepository()),
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      spacing: 25,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/logo_text_black.png",
                              height: 50,
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 4,
                              width: 50,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Secure Access",
                              style: theme.textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Welcome back! Please enter your details to sign in.",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.hintColor,
                              ),
                            ),
                          ],
                        ),

                        Form(
                          key: _formKey,
                          child: Column(
                            spacing: 16,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textFieldCustomWidget(
                                controller: _emailController,
                                context: context,
                                label: "Email",
                                hintText: "name@managex.com",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email";
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
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  BlocConsumer<LoginBloc, LoginState>(
                                    listener: (context, state) {
                                      if (state is LoginLoading) {
                                        isLoading = true;
                                      }
                                      if (state is LoginSuccess) {
                                        Navigator.pushNamed(
                                          context,
                                          Routers.verifyOtp,
                                        );
                                      } else if (state is LoginError) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(state.message),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is LoginLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                theme.colorScheme.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            shadowColor:
                                                theme.colorScheme.primary,
                                            elevation: 3,
                                          ),
                                          onPressed: state is LoginLoading
                                              ? null
                                              : () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    context.read<LoginBloc>().add(
                                                      LoginSubmitted(
                                                        email: _emailController
                                                            .text,
                                                        password:
                                                            _passwordController
                                                                .text,
                                                      ),
                                                    );
                                                  }
                                                },
                                          child: state is LoginLoading
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : Text(
                                                  "Login",
                                                  style: theme
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                        color: theme
                                                            .colorScheme
                                                            .onPrimary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 0.1,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ),
                            Text(
                              "or".toUpperCase(),
                              style: theme.textTheme.labelSmall,
                            ),
                            Expanded(
                              child: Container(
                                height: 0.1,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: theme.textTheme.labelMedium,
                                  children: [
                                    TextSpan(
                                      text: "Register",
                                      style: theme.textTheme.labelMedium
                                          ?.copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                            context,
                                            Routers.register,
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "end-to-end encryption active v1.0.0".toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
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
