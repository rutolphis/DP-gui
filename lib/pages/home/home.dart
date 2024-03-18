import 'package:flutter/material.dart';
import 'package:gui_flutter/widgets/page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWidget(title: "Dashboard", body: Container());
  }
}
