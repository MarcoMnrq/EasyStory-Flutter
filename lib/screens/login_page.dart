import 'package:easystory/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoGradiente = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(0, 94, 125, 1.0),
        Color.fromRGBO(70, 108, 162, 1.0),
      ])),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: [
        fondoGradiente,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 75.0),
          child: Column(
            children: [
              Icon(Icons.book_rounded, color: Colors.white, size: 100.0),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Easy Story',
                style: TextStyle(color: Colors.white, fontSize: 28.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: [
        SafeArea(
            child: Container(
          height: 190.0,
        )),
        Container(
          width: size.width * 0.85,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 50.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]),
          child: Column(
            children: [
              Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 19.0),
              ),
              SizedBox(height: 30.0),
              _emailTextBox(),
              SizedBox(height: 30.0),
              _passwordTextBox(),
              SizedBox(height: 30.0),
              _loginBtn(context),
            ],
          ),
        ),
        Text('¿Ha olvidado su contraseña?'),
        SizedBox(
          height: 90.0,
        )
      ],
    ));
  }

  Widget _emailTextBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'ejemplo@gmail.com',
          labelText: 'Correo electrónico',
        ),
      ),
    );
  }

  Widget _passwordTextBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: 'Contraseña',
        ),
      ),
    );
  }

  Widget _loginBtn(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Ingresar'),
        ));
  }
}
