import 'package:flutter/material.dart';
import 'package:flutter_cep_study/features/adress_by_cep/presentation/pages/address_page.dart';
import 'package:flutter_cep_study/initial_configs.dart';
import 'injection_container.dart' as di;

void main() async {
  await initialConfigs();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
       ),
      home: AddressPage(),
    );
  }
}
