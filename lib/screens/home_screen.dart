import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';
import 'package:wordle_app/providers/acount_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? headline42 = Theme.of(context).textTheme.headline4;
    AcountProvider acountProvider =
        Provider.of<AcountProvider>(context, listen: false);
    acountProvider.selectedUser().then(
        (_) => _showDialog(context, acountProvider.userGame, acountProvider));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //TODO: QUITAR ESTO
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DatabaseList(
                                  dbPath:
                                      '/data/user/0/com.example.wordle_app/databases/')));
                    },
                    child: const Icon(Icons.list),
                  ),

                  //const SizedBox(width: 40),
                  Text('¡Bienvenido!',
                      style: headline42, textAlign: TextAlign.center),
                  IconButton(
                    splashRadius: 30,
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: headline42?.color,
                    ),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.pushNamed(context, "AcountScreen");
                    },
                  )
                ],
              ),
              const SizedBox(height: 25),
              Image.asset('assets/img/logo-animado.gif'),
              const SizedBox(height: 100),
              Text(
                'Modos de juego',
                style: TextStyle(color: headline42?.color, fontSize: 25),
              ),
              Divider(
                thickness: 2,
                color: headline42?.color,
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
      ),
    );
  }

  dynamic _showDialog(BuildContext context, value, acountProvider) {
    if (value == null) {
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: AlertDialog(
              scrollable: true,
              title: Image.asset(
                'assets/img/logo.png',
                height: 125,
              ),
              titlePadding:
                  const EdgeInsets.only(top: 20, bottom: 0, left: 0, right: 0),
              contentPadding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('¡Crea tu cuenta!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  const Text('Para jugar, debes crear una cuenta.'),
                  const SizedBox(height: 25),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                    ),
                    onChanged: (value) => acountProvider.nickname = value,
                    validator: (value) {
                      if (value == '') {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                    ),
                    onChanged: (value) => acountProvider.password = value,
                    validator: (value) {
                      if (value == '') {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                    child: const Text(
                      'Crear',
                      style: TextStyle(color: Color(0xffc9b458), fontSize: 20),
                    ),
                    onPressed: () {
                      (acountProvider.createUser())
                          ? Navigator.pop(context)
                          : null;
                    }),
              ],
            ),
          );
        },
      );
    }
    return null;
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
