import 'package:academia/componentes/button.dart';
import 'package:academia/componentes/my_text_field.dart';
import 'package:academia/screen/train_me_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  RegisterPage({
    super.key,
    required this.showLoginPage,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final displayNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //validator email
  String? Function(String?) validatorEmail(String _controller) {
    return (String? _controller) {
      if (_controller == null || _controller.isEmpty) {
        return "E-mail necessário";
      } else if (!RegExp(r'\w+@\w+\.\w+').hasMatch(_controller)) {
        return "Formato de e-mail inválido";
      } else {
        return null;
      }
    };
  }

  //validator password
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String? Function(String?) validatorPassword(String _controller) {
    return (String? _controller) {
      if (_controller == null || _controller.isEmpty) {
        return "Senha necessária";
      } else if (!RegExp(pattern).hasMatch(_controller)) {
        return "Senha deve conter: \n- 8 caracteres. \n- uma letra maiúscula. \n- uma minúscula. \n- um número. \n- um caractere especial.";
      } else {
        return null;
      }
    };
  }

  //valide confirm password

  String? Function(String?) validatorConfirmPassword(String _controller) {
    return (String? _controller) {
      if (_controller == null || _controller.isEmpty) {
        return "Senha necessária";
      } else if (!passwordConfirmed()) {
        return "Senha diferente";
      } else {
        return null;
      }
    };
  }

  //valide username
  String? Function(String?) validatorUsername(String _controller) {
    return (String? _controller) {
      if (_controller == null || _controller.isEmpty) {
        return "nome de usuário necessário";
      } else if (!RegExp(r'[a-z A-Z]').hasMatch(_controller)) {
        return "Formato de e-mail inválido";
      } else {
        return null;
      }
    };
  }

  //sign user function
  Future signUp() async {
    //loading page
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (formKey.currentState!.validate()) {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await credential.user
          ?.updateDisplayName(displayNameController.text.trim());
      await credential.user?.reload();
    }

    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrainMe()),
    );
  }

  //data user

  //password confirmed
  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 43, 69, 1),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //logo
                  Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                  ),
                  const SizedBox(height: 25),
                  //welcome back
                  Text(
                    'Seja bem vindo!',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  //email
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    validator: validatorEmail(emailController.text.trim()),
                  ),
                  const SizedBox(height: 25),
                  //username
                  MyTextField(
                    controller: displayNameController,
                    hintText: 'Nome de Usuário',
                    obscureText: false,
                    validator:
                        validatorUsername(displayNameController.text.trim()),
                  ),
                  const SizedBox(height: 25),
                  //password
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Senha',
                    obscureText: true,
                    validator:
                        validatorPassword(passwordController.text.trim()),
                  ),
                  const SizedBox(height: 25),
                  //confirm password
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirme a Senha',
                    obscureText: true,
                    validator: validatorConfirmPassword(
                        confirmPasswordController.text.trim()),
                  ),
                  const SizedBox(height: 10),

                  //sign in button
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: signUp,
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(18, 154, 194, 1),
                          foregroundColor: Colors
                              .black // Substitua 'Colors.red' pela cor que você deseja
                          ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  //register now
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Já possui conta?',
                              style: TextStyle(color: Colors.grey[700])),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Já sou um mebro',
                          style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          'Entre agora!',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
