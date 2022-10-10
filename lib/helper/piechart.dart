
import 'package:flipr/helper/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/response_body.dart';
import 'api_model.dart';


class PieChartGraph extends StatefulWidget {
  const PieChartGraph({Key? key}) : super(key: key);

  @override
  State<PieChartGraph> createState() => _PieChartGraphState();
}

class _PieChartGraphState extends State<PieChartGraph> {

  // PieData obj = PieData();
   List<Data> _chartData=[];
  Api apiCall = Api();
  SharedPrefManager prefs = SharedPrefManager();
  late TooltipBehavior _tooltipBehavior;
  List<Data> chartDataGraph=[];
  String temp="",empId="";
  getDataGraph() async {
    chartDataGraph = await getData();

    setState(() {
        _chartData = chartDataGraph;
    });
  }

  _loadEmpId() async {
    temp = await prefs.getEmpID();

    setState(() {
      empId = temp;
    });
  }


  @override
  void initState() {
    getDataGraph();

    _loadEmpId();

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

   getData() async {

    var break_val, meet_val, work_val;
    empId = await prefs.getEmpID();
    ResponseBody responseBody = await apiCall.getPieChart(empId);
    break_val = double.parse(responseBody.break_val.toString());
    meet_val = double.parse(responseBody.meet_val.toString());
    work_val = double.parse(responseBody.work_Val.toString());
    List<Data> data = [
      Data('Break', break_val),
      Data('Meeting', meet_val),
      Data('Work', work_val),
    ];
    return data;
  }
}
class Data {
  final String task;
  final double val;
  Data(this.task, this.val);
}


