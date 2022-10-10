import 'package:flutter/material.dart';

import '../helper/api_model.dart';



class PieData {
  Api apiCall = Api();
  Map piechart={};
  static double break_val=0,meet_val=0,work_val=0;
  void getData()async {
    piechart=await apiCall.getPieChart("6341c5de61449f25afebc39f");
    break_val=piechart['break'];
    meet_val=piechart['meeting'];
    work_val=piechart['work'];
  }

   static List<Data> data = [
    Data(name: 'Break', val: break_val, color: const Color(0xff0293ee)),
    Data(name: 'Meeting', val: meet_val, color: const Color(0xfff8b250)),
    Data(name: 'Work', val: work_val, color: Colors.black),

  ];
}

class Data {
  final String name;

  final double val;

  final Color color;

  Data({required this.name,required this.val, required this.color});
}