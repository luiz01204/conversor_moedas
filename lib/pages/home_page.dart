import 'package:flutter/material.dart';
import 'package:conversor_moedas/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map> dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = getData();
  }

  void _refreshData() {
    setState(() {
      dataFuture = getData();
    });
  }

  double? dolar;
  double? euro;
  double? bitcoin;
  double? cad;
  double? aud;


  final TextEditingController controllerDolar = TextEditingController();
  final TextEditingController controllerReal = TextEditingController();
  final TextEditingController controllerEuro = TextEditingController();
  final TextEditingController controllerBitcoin = TextEditingController();
  final TextEditingController controllerCAD = TextEditingController();
  final TextEditingController controllerAUD = TextEditingController();


  void realChanged(String text) {
    if (text.isEmpty) {
      controllerEuro.text = "";
      controllerDolar.text = "";
      controllerBitcoin.text = "";
      controllerCAD.text = "";
      controllerAUD.text = "";
      return;
    }
    double real = double.parse(text);
    controllerEuro.text = (real / euro!).toStringAsFixed(2);
    controllerDolar.text = (real / dolar!).toStringAsFixed(2);
    controllerBitcoin.text = (real / bitcoin!).toStringAsFixed(8);
    controllerCAD.text = (real / cad!).toStringAsFixed(2);
    controllerAUD.text = (real / aud!).toStringAsFixed(2);
  }

  void dolarChanged(String text) {
    if (text.isEmpty) {
      controllerReal.text = "";
      controllerEuro.text = "";
      controllerBitcoin.text = "";
      controllerCAD.text = "";
      controllerAUD.text = "";
      return;
    }
    double dolar = double.parse(text);
    controllerReal.text = (dolar * this.dolar!).toStringAsFixed(2);
    controllerEuro.text = ((dolar * this.dolar!) / euro!).toStringAsFixed(2);
    controllerBitcoin.text = ((dolar * this.dolar!) / bitcoin!).toStringAsFixed(8);
    controllerCAD.text = ((dolar * this.dolar!) / cad!).toStringAsFixed(2);
    controllerAUD.text = ((dolar * this.dolar!) / aud!).toStringAsFixed(2);
  }

  void euroChanged(String text) {
    if (text.isEmpty) {
      controllerReal.text = "";
      controllerDolar.text = "";
      controllerBitcoin.text = "";
      controllerCAD.text = "";
      controllerAUD.text = "";
      return;
    }
    double euro = double.parse(text);
    controllerReal.text = (euro * this.euro!).toStringAsFixed(2);
    controllerDolar.text = ((euro * this.euro!) / dolar!).toStringAsFixed(2);
    controllerBitcoin.text = ((euro * this.euro!) / bitcoin!).toStringAsFixed(8);
    controllerCAD.text = ((euro * this.euro!) / cad!).toStringAsFixed(2);
    controllerAUD.text = ((euro * this.euro!) / aud!).toStringAsFixed(2);
  }

  void bitcoinChanged(String text) {
    if (text.isEmpty) {
      controllerReal.text = "";
      controllerDolar.text = "";
      controllerEuro.text = "";
      controllerCAD.text = "";
      controllerAUD.text = "";
      return;
    }
    double bitcoin = double.parse(text);
    controllerReal.text = (bitcoin * this.bitcoin!).toStringAsFixed(2);
    controllerDolar.text = ((bitcoin * this.bitcoin!) / dolar!).toStringAsFixed(2);
    controllerEuro.text = ((bitcoin * this.bitcoin!) / euro!).toStringAsFixed(2);
    controllerCAD.text = ((bitcoin * this.bitcoin!) / cad!).toStringAsFixed(2);
    controllerAUD.text = ((bitcoin * this.bitcoin!) / aud!).toStringAsFixed(2);
  }

  void cadChanged(String text) {
    if (text.isEmpty) {
      controllerReal.text = "";
      controllerDolar.text = "";
      controllerEuro.text = "";
      controllerBitcoin.text = "";
      controllerAUD.text = "";
      return;
    }
    double cad = double.parse(text);
    controllerReal.text = (cad * this.cad!).toStringAsFixed(2);
    controllerDolar.text = ((cad * this.cad!) / dolar!).toStringAsFixed(2);
    controllerEuro.text = ((cad * this.cad!) / euro!).toStringAsFixed(2);
    controllerBitcoin.text = ((cad * this.cad!) / bitcoin!).toStringAsFixed(8);
    controllerAUD.text = ((cad * this.cad!) / aud!).toStringAsFixed(2);
  }

  void audChanged(String text) {
    if (text.isEmpty) {
      controllerReal.text = "";
      controllerDolar.text = "";
      controllerEuro.text = "";
      controllerBitcoin.text = "";
      controllerCAD.text = "";
      return;
    }
    double aud = double.parse(text);
    controllerReal.text = (aud * this.aud!).toStringAsFixed(2);
    controllerDolar.text = ((aud * this.aud!) / dolar!).toStringAsFixed(2);
    controllerEuro.text = ((aud * this.aud!) / euro!).toStringAsFixed(2);
    controllerBitcoin.text = ((aud * this.aud!) / bitcoin!).toStringAsFixed(8);
    controllerCAD.text = ((aud * this.aud!) / cad!).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Conversor de moedas"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _refreshData,
              icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: FutureBuilder(
        future: dataFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar os dados. :C",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                  ),
                );
              } else {
                dolar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];
                bitcoin = snapshot.data?["results"]["currencies"]["BTC"]["buy"];
                cad = snapshot.data?["results"]["currencies"]["CAD"]["buy"];
                aud = snapshot.data?["results"]["currencies"]["AUD"]["buy"];


                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16),
                      Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 150,
                      ),
                      SizedBox(height: 20),
                      _buildTextField("Reais", "R\$ ", controllerReal, realChanged),
                      SizedBox(height: 20),
                      _buildTextField("Dólares", "US\$ ", controllerDolar, dolarChanged),
                      SizedBox(height: 20),
                      _buildTextField("Euros", "€ ", controllerEuro, euroChanged),
                      SizedBox(height: 20),
                      _buildTextField("Bitcoin", "BTC ", controllerBitcoin, bitcoinChanged),
                      SizedBox(height: 20),
                      _buildTextField("Dolar Canadence", "C\$ ", controllerCAD, cadChanged),
                      SizedBox(height: 20),
                      _buildTextField("Dolar Australiano", "A\$ ", controllerAUD, audChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget _buildTextField(String label, String prefix, TextEditingController controller, Function(String) onChanged) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        prefixText: prefix,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 1.0),
        ),
      ),
      style: TextStyle(color: Colors.amber, fontSize: 25),
    );
  }
}