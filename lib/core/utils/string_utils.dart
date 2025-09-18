class StringUtils {
  static String truncateWithEllipsis({
    required String? text,
    int maxLength = 10,
    String ellipsis = '...',
  }) {
    if (text == null || text.isEmpty) {
      return '';
    }

    String trimmedText = text.trim();

    if (trimmedText.length <= maxLength) {
      return trimmedText;
    }

    return '${trimmedText.substring(0, maxLength)}$ellipsis';
  }

  static String truncateForDropdown(String? text) {
    return truncateWithEllipsis(
      text: text,
      maxLength: 12,
      ellipsis: '...',
    );
  }
}
