import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AcountScreen extends StatelessWidget {
  const AcountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Cuenta',
          textAlign: TextAlign.center,
        ),
        actions: const [
          Icon(
            Icons.account_box_rounded,
            size: 30,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        width: double.infinity,
        height: 300,
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
                child: const Text('Guardar'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
