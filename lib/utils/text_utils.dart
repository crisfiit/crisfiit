class TextUtils {

  static String normalize(String text) {

    text = text
        .toLowerCase()
        .replaceAll('\u00A0', ' ') // NBSP → espacio normal
        .trim();

    const withAccent = [
      'á','à','ä','â',
      'é','è','ë','ê',
      'í','ì','ï','î',
      'ó','ò','ö','ô',
      'ú','ù','ü','û',
      'ñ'
    ];

    const withoutAccent = [
      'a','a','a','a',
      'e','e','e','e',
      'i','i','i','i',
      'o','o','o','o',
      'u','u','u','u',
      'n'
    ];

    for (int i = 0; i < withAccent.length; i++) {
      text = text.replaceAll(withAccent[i], withoutAccent[i]);
    }

    // limpiar espacios múltiples
    text = text.replaceAll(RegExp(r'\s+'), ' ');

    return text;
  }

}