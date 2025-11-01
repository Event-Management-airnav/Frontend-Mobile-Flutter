import 'package:get/get.dart';

import '../../data/network/services/event_detail_service.dart';
import 'event_detail_controller.dart';

class EventDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventDetailService>(() => EventDetailService(), fenix: true);
    Get.put<EventDetailController>(EventDetailController());
  }
}
