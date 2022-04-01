import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Image.asset('assets/img/logo.png'),
            ),
            Text('Ingresar', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      child: const Text('Iniciar'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.white.withOpacity(0.2)),
                elevation: MaterialStateProperty.all<double>(0),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              child: const Text(
                '¿Aun no tienes cuenta?',
                style: TextStyle(fontSize: 18, color: Colors.white60),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
