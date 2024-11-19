import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../services/auth_service.dart';
import '../widgets/authentication/custom_input.dart';
import '../widgets/authentication/custom_input_password.dart';
import '../widgets/authentication/custom_loading.dart';
import '../widgets/authentication/error_auth.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final AuthService authService;

  const RegisterScreen({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Registrar"),
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
                  'Crie sua conta',
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
                  controller: authService.emailControllerRegister,
                  textInputType: TextInputType.emailAddress,
                  label: 'Email',
                  hintText: 'Digite seu email',
                ),
              ),
              const SizedBox(height: 20),
              SlideInUp(
                delay: const Duration(milliseconds: 400),
                child: CustomInputPassword(
                  controller: authService.passwordControllerRegister,
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
              const SizedBox(height: 20),
              SlideInUp(
                delay: const Duration(milliseconds: 600),
                child: CustomLoading(
                  listenable: authService.isLoading,
                  textButton: "Cadastre-se",
                  action: () {
                    authService.register(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              SlideInUp(
                delay: const Duration(milliseconds: 800),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(authService: authService),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0.0);
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
                    "Já tem uma conta? Faça login",
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