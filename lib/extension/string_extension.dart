extension StringExtension on String {
  String capitalize() {
    if (this.isNotEmpty)
      return "${this[0].toUpperCase()}${this.substring(1)}";
    else
      return " ";
  }

  String capitalises() {
    List<String> list = this.split("\\s");
    list = list.map((e) => e.capitalize()).toList();
    return list.join(" ");
  }
}
