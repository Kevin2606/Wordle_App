import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Text('¡Bienvenido!', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 25),
            Image.asset('assets/img/logo-animado.gif'),
            const SizedBox(height: 100),
            Text(
              'Modos de juego',
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline4?.color,
                  fontSize: 25),
            ),
            Divider(
              thickness: 2,
              color: Theme.of(context).textTheme.headline4?.color,
              indent: 50,
              endIndent: 50,
            ),
            const SizedBox(height: 75),
            const _ItemGame(text: 'Contrareloj'),
            const SizedBox(height: 25),
            const _ItemGame(text: 'Normal'),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

class _ItemGame extends StatelessWidget {
  final String text;
  const _ItemGame({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          color: const Color(0xff6aaa64),
          width: 2,
        ),
      ),
      child: TextButton(
        onPressed: () {
          if (text == 'Contrareloj') {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Contrareloj',
                          textAlign: TextAlign.center),
                      content: const Text('¡No implementado aún!',
                          textAlign: TextAlign.center),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Cerrar',
                            style: TextStyle(color: Color(0xffc9b458)),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ));
          } else {
            Navigator.pushNamed(context, 'GameScreen');
          }
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
          ),
          overlayColor:
              MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.2)),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
