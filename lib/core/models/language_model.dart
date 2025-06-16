class Language {
  final String code;
  final String name;
  final String flagAsset;

  const Language({
    required this.code,
    required this.name,
    required this.flagAsset,
  });

  static const List<Language> supportedLanguages = [
    Language(
      code: 'en',
      name: 'English',
      flagAsset: 'assets/flags/us.png',
    ),
    Language(
      code: 'es',
      name: 'Español',
      flagAsset: 'assets/flags/es.png',
    ),
    Language(
      code: 'zh',
      name: '中文（繁體）',
      flagAsset: 'assets/flags/tw.png',
    ),
    Language(
      code: 'ja',
      name: '日本語',
      flagAsset: 'assets/flags/jp.png',
    ),
    Language(
      code: 'de',
      name: 'Deutsch',
      flagAsset: 'assets/flags/de.png',
    ),
    Language(
      code: 'fr',
      name: 'Français',
      flagAsset: 'assets/flags/fr.png',
    ),
    Language(
      code: 'pt',
      name: 'Português (BR)',
      flagAsset: 'assets/flags/br.png',
    ),
    Language(
      code: 'ru',
      name: 'Русский',
      flagAsset: 'assets/flags/ru.png',
    ),
    Language(
      code: 'ko',
      name: '한국어',
      flagAsset: 'assets/flags/kr.png',
    ),
    Language(
      code: 'it',
      name: 'Italiano',
      flagAsset: 'assets/flags/it.png',
    ),
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Language && runtimeType == other.runtimeType && code == other.code;

  @override
  int get hashCode => code.hashCode;
} 