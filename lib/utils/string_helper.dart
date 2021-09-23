class StringHelper {
  static List<String> vietnameseSigns = [
    "aAeEoOuUiIdDyY",
    "áàạảãâấầậẩẫăắằặẳẵ",
    "ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ",
    "éèẹẻẽêếềệểễ",
    "ÉÈẸẺẼÊẾỀỆỂỄ",
    "óòọỏõôốồộổỗơớờợởỡ",
    "ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ",
    "úùụủũưứừựửữ",
    "ÚÙỤỦŨƯỨỪỰỬỮ",
    "íìịỉĩ",
    "ÍÌỊỈĨ",
    "đ",
    "Đ",
    "ýỳỵỷỹ",
    "ÝỲỴỶỸ"
  ];

  static String removeSignVietnameseString(String str) {
    if (str != null) {
      for (int i = 1; i < vietnameseSigns.length; i++) {
        for (int j = 0; j < vietnameseSigns[i].length; j++)
          str =
              str.replaceAll(vietnameseSigns[i][j], vietnameseSigns[0][i - 1]);
      }
    }
    return str;
  }
}
