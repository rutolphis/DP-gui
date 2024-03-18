import 'package:flutter/material.dart';
class PageWidget extends StatelessWidget {
  final String title;
  final Widget body;

  const PageWidget({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(children: [
            Text(title)
          ],),
          const SizedBox(height: 40,),
          body
        ],
      ),
    );
  }
}
