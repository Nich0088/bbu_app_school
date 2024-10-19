enum Language {
  khmer('km'),
  english('en');

  final String languageKey;

  const Language(this.languageKey);

  static Language getLanguage({required String languageKey}) {
    switch (languageKey) {
      case 'km':
        return Language.khmer;
      case 'en':
        return Language.english;
    }

    return Language.english;
  }
}
