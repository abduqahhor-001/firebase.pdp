class Post {
  String? firstname;
  String? lastname;
  String? content;
  String? date;
  String? imageUrl; // Add this line

  Post({this.firstname, this.lastname, this.content, this.date, this.imageUrl}); // Update the constructor

  // Add a factory method to create a Post from a map (if you're using maps)
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      firstname: map['firstname'],
      lastname: map['lastname'],
      content: map['content'],
      date: map['date'],
      imageUrl: map['imageUrl'],
    );
  }

  // Add a method to convert a Post to a map (if you're using maps)
  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'content': content,
      'date': date,
      'imageUrl': imageUrl,
    };
  }
}
