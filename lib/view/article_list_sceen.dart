import 'package:flutter/material.dart';
import '../component/my_component.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: appBar(textTheme,"مقالات جدید"),
    ));
  }

}
