import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = new TextEditingController();
  TextEditingController alturaController = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe seus Dados!";

  void reset() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _info = "Informe seus Dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _info = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9)
        _info = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      else if (imc >= 24.9 && imc < 29.9)
        _info = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      else if (imc >= 29.9 && imc < 34.9)
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      else if (imc >= 34.9 && imc < 39.9)
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      else if (imc > 40)
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora ImC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              reset();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outlined, size: 120.0, color: Colors.green),
              TextFormField(
                validator: (value) {
                  if (value == "") {
                    return "Insira seu Peso!";
                  }
                },
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              TextFormField(
                validator: (value) {
                  if (value == "") {
                    return "Insira a Altura!";
                  }
                },
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (Cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 70.0,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        calcular();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
