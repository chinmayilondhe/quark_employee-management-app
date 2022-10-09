import 'package:flipr/screens/pie_chart_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(Text: ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: PageView(
          children: [
            PieChartPage(),
          ],
        ),
      ),
    );
  }
}
