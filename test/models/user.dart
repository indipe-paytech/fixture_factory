import 'comment.dart';
import 'post.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final DateTime dateOfBirth;
  final List<Post>? posts;

  final List<Comment>? comments;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.dateOfBirth,
    required this.posts,
    required this.comments,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? mobile,
    DateTime? dateOfBirth,
    List<Post>? posts,
    List<Comment>? comments,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      posts: json['posts'] != null
          ? (json['posts'] as List).map((i) => Post.fromJson(i)).toList()
          : null,
      comments: json['comments'] != null
          ? (json['comments'] as List).map((i) => Comment.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['dateOfBirth'] = dateOfBirth.toIso8601String();
    data['posts'] = posts?.map((i) => i.toJson()).toList();
    data['comments'] = comments?.map((i) => i.toJson()).toList();
    return data;
  }
}
