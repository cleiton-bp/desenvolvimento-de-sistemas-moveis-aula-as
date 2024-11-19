import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../services/auth_service.dart';
import '../widgets/authentication/custom_input.dart';
import '../widgets/authentication/custom_input_password.dart';
import '../widgets/authentication/error_auth.dart';
import '../widgets/authentication/custom_loading.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthService authService;

  const LoginScreen({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.10,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideInUp(
                child: const Text(
                  'Bem-vindo de volta!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SlideInUp(
                delay: const Duration(milliseconds: 200),
                child: CustomInput(
                  controller: authService.emailController,
                  textInputType: TextInputType.emailAddress,
                  label: 'Email',
                  hintText: 'Digite seu email',
                ),
              ),
              const SizedBox(height: 20),
              SlideInUp(
                delay: const Duration(milliseconds: 400),
                child: CustomInputPassword(
                  controller: authService.passwordController,
                  textInputType: TextInputType.visiblePassword,
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                ),
              ),
              const SizedBox(height: 20),
              ErrorAuth(
                listenable: authService.isErrorGeneric,
                messageError: "Um problema ocorreu",
              ),
              ErrorAuth(
                listenable: authService.isErrorCredential,
                messageError: "Suas credenciais estão inválidas",
              ),
              const SizedBox(height: 20),
              SlideInUp(
                delay: const Duration(milliseconds: 600),
                child: CustomLoading(
                  listenable: authService.isLoading,
                  textButton: "Entrar",
                  action: () {
                    authService.login(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              SlideInUp(
                delay: const Duration(milliseconds: 800),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(authService: authService),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Cadastre-se",
                    style: TextStyle(color: Colors.teal),
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