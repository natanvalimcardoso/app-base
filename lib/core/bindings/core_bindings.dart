import 'package:get/get.dart';

import '../../modules/initial/initial_controller.dart';
import '../../modules/home/home_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/theme_controller.dart';
import '../services/ad_service.dart';

class CoreBindings extends Bindings {
  @override
  void dependencies() {
    // Serviços principais
    Get.put<AdService>(AdService(), permanent: true);

    // Controllers
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.put<ThemeController>(ThemeController(), permanent: true); // Carrega imediatamente
    Get.lazyPut<InitialController>(
      () => InitialController(
        languageController: Get.find<LanguageController>(),
        themeController: Get.find<ThemeController>(),
      ),
    );
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
