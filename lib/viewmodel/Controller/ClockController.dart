import 'package:get/get.dart';
import 'dart:async';
import 'package:intl/intl.dart';
class ClockController extends GetxController {
  
  RxString currentTime = ''.obs;
final CurrentTime = DateTime.now().obs;

   Timer? timer;

  @override
  void onInit() {
    super.onInit();
    _startClock();
  }


  void _startClock() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
        CurrentTime.value = DateTime.now();
      currentTime.value = _getCurrentTime();
    });
  }

 
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${(now.hour - 12 <10)?'0${now.hour - 12}':now.hour - 12}:${now.minute.toString().padLeft(2, '0')} ${ DateFormat('a').format(now) }';
  }

 
  @override
  void onClose() {
    timer!.cancel();
    super.onClose();
  }
}
