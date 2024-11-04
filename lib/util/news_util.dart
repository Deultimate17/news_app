class Util {
  static String appId = 'cdfbc4f25a2146b3a9a02fdc8eafec61';

  static DateTime getNow() {
    return DateTime.now();
  }

  static DateTime getYesterday() {
    return DateTime.now().subtract(Duration(days: 1));
  }
}
