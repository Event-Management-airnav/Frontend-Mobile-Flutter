import 'package:get/get.dart';
import '../../data/models/event/event_detail.dart';
import '../../data/network/services/event_detail_service.dart';

class EventDetailController extends GetxController {
  final EventDetailService eventDetailService = Get.find<EventDetailService>();


  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final eventDetail = Rxn<EventDetail>();

  Future<void> loadEventDetail(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await eventDetailService.getEventDetail(id);
      eventDetail.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      eventDetail.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  bool get hasError => errorMessage.isNotEmpty;
  bool get hasData => eventDetail.value != null;
}
