class WhitePaper {
  String name = '';
  String url = '';

  WhitePaper(String name, String url) {
    this.name = name;
    this.url = url;
  }

  String toString() {
    return "Name: $name\nUrl: $url";
  }
}
