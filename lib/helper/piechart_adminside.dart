import 'package:flipr/helper/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/response_body.dart';
import 'api_model.dart';

class PieChartGraphAdmin extends StatefulWidget {
  final String empID;

  const PieChartGraphAdmin({Key? key,required this.empID}) : super(key: key);

  @override
  State<PieChartGraphAdmin> createState() => _PieChartGraphAdminState();
}

class _PieChartGraphAdminState extends State<PieChartGraphAdmin> {
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

    setState(() {
      empId = widget.empID;
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
          body: Container(
            margin: EdgeInsets.all(18),
            height: 300,
            width: 350,
            child: SfCircularChart(
              backgroundColor: Colors.lightGreen.shade100,
              // margin: EdgeInsets.all(15),
              title: ChartTitle(text: 'Task Distribution of Employee',
                  textStyle: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
              legend:
              Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.top,toggleSeriesVisibility: true,
                  offset: Offset(10, 2),height: '30%'),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<Data, String>(
                  radius: '75%',
                  dataSource: _chartData,
                  xValueMapper: (Data data, _) => data.task,
                  yValueMapper: (Data data, _) => data.val,
                  dataLabelSettings: DataLabelSettings(isVisible: true,
                      textStyle: TextStyle(fontSize: 15,color: Colors.white)),
                  enableTooltip: true,
                )
              ],
            ),
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