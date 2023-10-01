import 'package:dev_opportunity/base/presentation/widgets/buttons/main_button.dart';
import 'package:dev_opportunity/base/presentation/widgets/loader.dart';
import 'package:dev_opportunity/base/utils/input_validators/email.dart';
import 'package:dev_opportunity/base/utils/input_validators/password.dart';
import 'package:dev_opportunity/user/presentation/widgets/bottom_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dev_opportunity/base/presentation/widgets/inputs/text_input.dart';
import 'package:dev_opportunity/base/presentation/widgets/inputs/password_input.dart';
import 'package:dev_opportunity/user/presentation/view_models/user_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserViewModel _viewModel = UserViewModel();
  bool _isLoading = false;

  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // focus nodes
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // errors
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emailValidator = EmailValidator(context);
    final passwordValidator = PasswordValidator(context, false);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Center(
                        child: Text(
                          "Dev Opportunity",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 50,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic
                          )
                        )
                    ),
                  ),
                  TextInput(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    inputAction: TextInputAction.next,
                    prefixIcon: CupertinoIcons.envelope_fill,
                    label: "Email",
                    placeholder: "johndoe@gmail.com",
                    error: _emailError,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  const SizedBox(height: 15,),
                  PasswordInput(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    inputAction: TextInputAction.done,
                    error: _passwordError,
                    label: "Password",
                    showIcon: true,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Placeholder())
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: theme.colorScheme.primary
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  _isLoading ? const Loader(size: 24) : Button(
                    text: "LOGIN",
                    onTap: () {
                      setState(() {
                        _emailError = emailValidator(_emailController.text);
                        _passwordError = passwordValidator(_passwordController.text, null);
                      });

                      final errors = [_emailError, _passwordError];

                      if(errors.every((error) => error == null)) {
                        FocusScope.of(context).unfocus();
                        // login function
                      }
                    },
                  ),
                  BottomInfo(
                      info: "Don't have an account ?",
                      btnText: "REGISTER",
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Placeholder()
                            )
                        );
                      }
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
