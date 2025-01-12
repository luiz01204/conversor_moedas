import 'package:conversor_moedas/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
const request = "https://api.hgbrasil.com/finance?format=json-cors&key=c6cd0be8";

void main(){
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage()
      )
  );
}

Future<Map> getData() async {
  final req = await http.get(Uri.parse(request));
  if (req.statusCode == 200) {
    return json.decode(req.body);
  } else {
    throw Exception("Erro ao carregar os dados: ${req.statusCode}");
  }
}