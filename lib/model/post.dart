class Post {
  int? id;
  String? firstname;
  String? lastname;
  String? content;
  String? date;

  Post({this.id, this.firstname, this.lastname, this.content, this.date});

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        content = json['content'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstname': firstname,
    'lastname': lastname,
    'content': content,
    'date': date,
  };
}