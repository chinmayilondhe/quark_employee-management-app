import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/pie_data.dart';

class PieChartGraph extends StatefulWidget {
  const PieChartGraph({Key? key}) : super(key: key);

  @override
  State<PieChartGraph> createState() => _PieChartGraphState();
}

class _PieChartGraphState extends State<PieChartGraph> {
  PieData obj = PieData();
   List<Data> _chartData=[];
  late TooltipBehavior _tooltipBehavior;
  List<Data> chartDataGraph=[];

  getDataGraph() async {
    chartDataGraph = await obj.getData();
    setState(() {
        _chartData = chartDataGraph;
    });
  }

  @override
  void initState() {
    getDataGraph();
  
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCircularChart(
        title: ChartTitle(text: 'Task Distribution of Employee'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          PieSeries<Data, String>(
            dataSource: _chartData,
            xValueMapper: (Data data, _) => data.task,
            yValueMapper: (Data data, _) => data.val,
            dataLabelSettings: DataLabelSettings(isVisible: true,
            textStyle: TextStyle(fontSize: 25,color: Colors.white)),
            enableTooltip: true,
          )
        ],
      ),
    ));
  }
}
