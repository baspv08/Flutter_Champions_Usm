import 'package:flutter/material.dart';
import 'package:flutter_champions/pages/Pantalla_Home.dart';
import 'package:flutter_champions/pages/Pantalla_Registro.dart';
import 'package:flutter_champions/services/firestore_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Pantalla_Autentificar extends StatefulWidget {
  @override
  State<Pantalla_Autentificar> createState() => _Pantalla_AutentificarState();
}

class _Pantalla_AutentificarState extends State<Pantalla_Autentificar> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _signInWithEmail() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      final user = await AuthService().signInWithEmail(email, password);
      if (user != null) {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) => Pantalla_Home());
                      Navigator.push(context, route);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al iniciar sesión')));
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 50),
                SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    final user = await AuthService().signInWithGoogle();
                    if (user != null) {
                      MaterialPageRoute route = MaterialPageRoute(builder: (context) => Pantalla_Home());
                      Navigator.push(context, route);
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'o',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu correo electrónico';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signInWithEmail,
                  child: Text('Iniciar Sesión'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(builder: (context) => Pantalla_Registro());
                      Navigator.push(context, route);
                  },
                  child: Text('¿No tienes una cuenta? Regístrate aquí'),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
