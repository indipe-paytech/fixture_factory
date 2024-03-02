import 'post.dart';
import 'user.dart';

class Comment {
  final int id;
  final String body;
  final int postId;
  final int? parentCommentId;
  final int userId;
  final DateTime createdAt;
  final User? user;
  final List<Comment>? replies;
  final Post? post;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.parentCommentId,
    required this.userId,
    required this.createdAt,
    required this.user,
    required this.replies,
    required this.post,
  });

  Comment copyWith({
    int? id,
    String? body,
    int? postId,
    int? parentCommentId,
    int? userId,
    DateTime? createdAt,
    User? user,
    List<Comment>? replies,
    Post? post,
  }) {
    return Comment(
      id: id ?? this.id,
      body: body ?? this.body,
      postId: postId ?? this.postId,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      replies: replies ?? this.replies,
      post: post ?? this.post,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      body: json['body'],
      postId: json['post_id'],
      parentCommentId: json['parent_comment_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      replies: json['replies'] != null ? (json['replies'] as List).map((i) => Comment.fromJson(i)).toList() : null,
      post: json['post'] != null ? Post.fromJson(json['post']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    data['post_id'] = postId;
    data['parent_comment_id'] = parentCommentId;
    data['user_id'] = userId;
    data['created_at'] = createdAt.toIso8601String();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (replies != null) {
      data['replies'] = replies!.map((i) => i.toJson()).toList();
    }
    if (post != null) {
      data['post'] = post!.toJson();
    }
    return data;
  }
}
