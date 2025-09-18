import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("Home Page")]).scaffoldSafeArea();
  }
}
