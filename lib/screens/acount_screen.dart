import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/models/account_models.dart';
import 'package:wordle_app/providers/providers.dart';

class AcountScreen extends StatelessWidget {
  const AcountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AcountProvider acountProvider =
        Provider.of<AcountProvider>(context, listen: true);
    late Account user;
    (acountProvider.userGame == null)
        ? acountProvider.selectedUser()
        : user = acountProvider.userGame!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Cuenta',
          textAlign: TextAlign.center,
        ),
        actions: const [
          Icon(
            Icons.account_circle_outlined,
            size: 30,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: (acountProvider.isLoading)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Hola",
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.nickname,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    thickness: 2,
                    color: Theme.of(context).textTheme.headline4?.color,
                    indent: 50,
                    endIndent: 50,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Configura tu cuenta",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  const Divider(thickness: 2),
                  ListTile(
                    leading: const Icon(Icons.account_circle_outlined),
                    title: Text(
                      "Usuario",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Theme.of(context).textTheme.headline6?.color,
                    ),
                    onTap: () {
                      _showDialog(context, user, acountProvider, 'user');
                    },
                  ),
                  const Divider(thickness: 2),
                  ListTile(
                    leading: const Icon(Icons.vpn_key),
                    title: Text(
                      "Contraseña",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Theme.of(context).textTheme.headline6?.color,
                    ),
                    onTap: () {
                      _showDialog(context, user, acountProvider, 'password');
                    },
                  ),
                  const Divider(thickness: 2),
                  ListTile(
                    leading: const Icon(Icons.no_accounts),
                    title: Text(
                      "Cerrar sesión",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).textTheme.headline6?.color,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Cerrar sesion'),
                            content:
                                const Text('¿Estas seguro de cerrar sesion?'),
                            actions: [
                              ElevatedButton(
                                style: _customButtonStyle(Colors.red),
                                child: const Text('Salir'),
                                onPressed: () {
                                  acountProvider.deleteUser(user);
                                  Navigator.of(context)
                                      .pushReplacementNamed('HomeScreen');
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const Divider(thickness: 2),
                ],
              ),
            ),
    );
  }

  ButtonStyle _customButtonStyle(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(color),
    );
  }

  dynamic _showDialog(BuildContext context, Account user,
      AcountProvider acountProvider, String mode) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        late String newValue;
        return AlertDialog(
          title: Text(
              mode == 'user' ? 'Actualizar usuario' : 'Actualizar contraseña'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: TextEditingController(
                    text: mode == 'user' ? user.nickname : null,
                  ),
                  decoration: InputDecoration(
                    hintText: mode == 'user' ? 'Usuario' : 'Contraseña',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onChanged: (value) => newValue = value,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: _customButtonStyle(const Color(0xff6aaa64)),
              child: const Text('Actualizar'),
              onPressed: () {
                mode == 'user'
                    ? user.nickname = newValue
                    : user.password = newValue;
                acountProvider.updateUser(user);
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



/*
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    height: 300,
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            initialValue: user.nickname,
                            decoration: const InputDecoration(
                              labelText: 'Usuario',
                            ),
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            autocorrect: false,
                            obscureText: true,
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

*/