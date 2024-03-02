import 'package:faker/faker.dart';
import 'package:fixture_factory/fixture_factory.dart';

import '../models/post.dart';
import 'user_factory.dart';

class PostFactory extends FixtureFactory<PostFactory, Post> {
  PostFactory([super.attributes]);

  var faker = Faker();

  @override
  Post definition() {
    return Post(
      title: faker.lorem.sentence(),
      body: faker.lorem.sentences(10).join("\n"),
      comments: [],
      owner: UserFactory().make(),
      createdAt: faker.date.dateTime(),
      publishedAt: faker.date.dateTime(),
    );
  }

  PostFactory withTitle(String title) =>
      apply((model) => model.copyWith(title: title));

  @override
  Post fromJson(Map<String, dynamic> json) => Post.fromJson(json);
}
