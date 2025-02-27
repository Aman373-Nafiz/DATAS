import 'dart:convert';

import 'package:datas/model/Datas.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
class ApiServiceController extends GetxController{
  final url ="https://datausa.io/api/data?drilldowns=Nation&measures=Population";
var datas = <Datum>[].obs;
  var isLoading = false.obs;
  Future<void>fetchData() async{
var response = await http.get(Uri.parse(url));
if(response.statusCode==200){
  isLoading.value = true;
  var body = jsonDecode(response.body);
  final List d = body['data'];
   datas.value = d.map((item) => Datum.fromJson(item)).toList();
   update();
}
else{
  Get.snackbar("Error", "Failed to load data ${response.statusCode}");
}
  }
}