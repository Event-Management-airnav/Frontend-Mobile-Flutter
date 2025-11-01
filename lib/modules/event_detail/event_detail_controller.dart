import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/models/event/event_detail.dart';
import '../../data/network/services/pendaftaran_service.dart';
import '../../data/network/services/event_detail_service.dart';

class EventDetailController extends GetxController {
  final EventDetailService eventService;
  final PendaftaranService daftarService;

  EventDetailController(this.eventService, this.daftarService);

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final eventDetail = Rxn<EventDetail>();
  final isRegistered = false.obs;
  final isUserLoggedIn = false.obs;

  Future<void> loadEventDetail(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final storage = GetStorage();
      isUserLoggedIn.value = storage.hasData('access_token');

      final detail = await eventService.getEventDetail(id);
      eventDetail.value = detail;

      if (isUserLoggedIn.value) {
        isRegistered.value = await daftarService.isRegistered(id);
      } else {
        isRegistered.value = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      eventDetail.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> register(int id) async {
    final result = await daftarService.daftarEvent(id);
    if (result == null) return "Unexpected error";

    if (result.success) {
      isRegistered.value = true;
      return null;
    }

    return result.message;
  }

  bool get hasError => errorMessage.isNotEmpty;
  bool get hasData => eventDetail.value != null;
}
