import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'terms_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();

  bool _agreeToTerms = false;
  bool _isLoading = false;
  String _selectedGender = '';

  Future<void> _register(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final birthDate = birthDateController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty || birthDate.isEmpty || _selectedGender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem.')),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você precisa aceitar os termos e condições.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user?.uid).set({
        'nome': name,
        'email': email,
        'telefone': phone,
        'nascimento': birthDate,
        'sexo': _selectedGender,
        'uid': userCredential.user?.uid,
        'data_criacao': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Erro ao cadastrar.';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'E-mail já está em uso.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'E-mail inválido.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Senha fraca. Use pelo menos 6 caracteres.';
      } else {
        errorMessage = 'Erro: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: const BorderSide(color: Color(0xFFCD3232), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cadastro',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCD3232),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(controller: nameController, decoration: _inputDecoration('Nome')),
                const SizedBox(height: 15),
                TextField(controller: emailController, decoration: _inputDecoration('E-mail'), keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 15),
                TextField(controller: phoneController, decoration: _inputDecoration('Telefone'), keyboardType: TextInputType.phone),
                const SizedBox(height: 15),
                TextField(controller: birthDateController, decoration: _inputDecoration('Data de Nascimento'), keyboardType: TextInputType.datetime),
                const SizedBox(height: 15),

                // Gênero
                Row(
                  children: [
                    Checkbox(
                      value: _selectedGender == 'Masculino',
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value! ? 'Masculino' : '';
                        });
                      },
                    ),
                    const Text('Masculino'),
                    Checkbox(
                      value: _selectedGender == 'Feminino',
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value! ? 'Feminino' : '';
                        });
                      },
                    ),
                    const Text('Feminino'),
                  ],
                ),

                TextField(controller: passwordController, obscureText: true, decoration: _inputDecoration('Senha')),
                const SizedBox(height: 15),
                TextField(controller: confirmPasswordController, obscureText: true, decoration: _inputDecoration('Repita a senha')),
                const SizedBox(height: 30),

                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen()));
                        },
                        child: Text(
                          'Concordo com os termos e condições',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : () => _register(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCD3232),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        : const Text('Cadastrar'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Já tem uma conta?', style: TextStyle(color: Colors.grey.shade600)),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Entre aqui', style: TextStyle(color: Color(0xFFCD3232))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
