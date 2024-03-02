import 'package:faker/faker.dart';
import 'package:fixture_factory/fixture_factory.dart';

import '../models/comment.dart';
import 'post_factory.dart';
import 'user_factory.dart';

class CommentFactory extends FixtureFactory<CommentFactory, Comment> {
  CommentFactory([super.attributes]);

  var faker = Faker();

  @override
  Comment definition() {
    return Comment(
      body: faker.lorem.sentences(10).join("\n"),
      createdAt: faker.date.dateTime(),
      id: faker.randomGenerator.integer(1000),
      postId: faker.randomGenerator.integer(1000),
      userId: faker.randomGenerator.integer(1000),
      parentCommentId: null,
      user: UserFactory().make(),
      replies: [],
      post: PostFactory().make(),
    );
  }

  @override
  Comment fromJson(Map<String, dynamic> json) => Comment.fromJson(json);
}
