
import 'package:explore_places/get_x/constant/resources/app_images.dart';
import 'package:explore_places/get_x/data_models/view_object/setup_vo.dart';

class LanguageEnums<String> {
  final String languageType;
  final String languageCode;

  const LanguageEnums(this.languageType, this.languageCode);

  static const LanguageEnums ENGLISH = LanguageEnums('English', "en");
  static const LanguageEnums Thailand = LanguageEnums("Myanmar", "th");
  static const LanguageEnums CHINESE = LanguageEnums("Chinese", "zh");
}

extension LanguageNameExtension on LanguageEnums {
  SetUpVo get languageData {
    switch (this) {
      case LanguageEnums.ENGLISH:
        return SetUpVo(name: "English", image: AppImages.icEnglishFlag);
      case LanguageEnums.Thailand:
        return SetUpVo(name: "Thai", image: AppImages.icThaiFlag);
      case LanguageEnums.CHINESE:
        return SetUpVo(name: "Chinese", image: AppImages.icChineseFlag);
      default:
        return SetUpVo(name: "English", image: AppImages.icEnglishFlag);
    }
  }
}
