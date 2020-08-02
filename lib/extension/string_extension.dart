extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String capitalises() {
    List<String> list = this.split(" ");
    list = list.map((e) => e.capitalize()).toList();
    return list.join(" ");
  }
}
