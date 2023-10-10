


class Todo {

  String title;
  String detail;

  String get getTitle => title;

  String get getDetail => detail;

  Todo(this.title, this.detail);

  void edit(String newTitle, String newDetail) {
    title = newTitle;
    detail = newDetail;
  }

}