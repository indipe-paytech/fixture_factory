import 'comment.dart';
import 'user.dart';

class Post {
  final String title;
  final String body;
  final List<Comment>? comments;
  final User? owner;
  final DateTime? createdAt;
  final DateTime? publishedAt;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      body: json['body'],
      comments: json['comments'] != null
          ? (json['comments'] as List).map((e) => Comment.fromJson(e)).toList()
          : null,
      owner: json['owner'] != null ? User.fromJson(json['owner']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
    );
  }

  Post(
      {required this.title,
      required this.body,
      required this.comments,
      required this.owner,
      required this.createdAt,
      required this.publishedAt});

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'comments': comments?.map((e) => e.toJson()).toList(),
        'owner': owner?.toJson(),
        'createdAt': createdAt?.toIso8601String(),
        'publishedAt': publishedAt?.toIso8601String(),
      };

  Post copyWith({
    String? title,
    String? body,
    List<Comment>? comments,
    User? owner,
    DateTime? createdAt,
    DateTime? publishedAt,
  }) {
    return Post(
      title: title ?? this.title,
      body: body ?? this.body,
      comments: comments ?? this.comments,
      owner: owner ?? this.owner,
      createdAt: createdAt ?? this.createdAt,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}
