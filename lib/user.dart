class User {
  static String name = "C"; //default name
  static bool catalogVisited = false;
  static bool pouchVisited = false;
  static bool coinVisited = false;
  static bool detectiveVisited = false;
  static bool newsVisited = false;

  setName(String name) {
    User.name = name;
  }

  visitCatalog() {
    catalogVisited = true;
  }

  visitPouch() {
    pouchVisited = true;
  }

  visitCoin() {
    coinVisited = true;
  }

  visitDetective() {
    detectiveVisited = true;
  }

  visitNews() {
    newsVisited;
  }
}
