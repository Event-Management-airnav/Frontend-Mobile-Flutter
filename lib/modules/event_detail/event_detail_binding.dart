import 'package:get/get.dart';
import '../../data/network/services/event_detail_service.dart';
import '../../data/network/services/pendaftaran_service.dart';
import 'event_detail_controller.dart';

class EventDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventDetailService());
    Get.lazyPut(() => PendaftaranService());
    Get.lazyPut(() => EventDetailController(Get.find(), Get.find()));
  }
}
