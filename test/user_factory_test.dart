import 'package:test/test.dart';

import 'factories/comment_factory.dart';
import 'factories/post_factory.dart';
import 'factories/user_factory.dart';
import 'models/post.dart';
import 'models/user.dart';

void main() {
  group('UserFactory', () {
    test('should create a user', () {
      final user = UserFactory().make();
      expect(user, isA<User>());
    });

    test('should create a user with specific name', () {
      final user = UserFactory().withAttribute("name", "John Doe").make();
      expect(user, isA<User>());
      expect(user.name, "John Doe");
    });

    test('should create a user with specific name 2', () {
      final user = UserFactory({
        "name": "John Doe",
      }).make();
      expect(user, isA<User>());
      expect(user.name, "John Doe");
    });

    test('should create a user with specific name 3', () {
      final user = UserFactory().withName("John Doe").make();
      expect(user, isA<User>());
      expect(user.name, "John Doe");
    });

    test('Should create a user with name and email', () {
      final user = UserFactory()
          .withAttribute('name', 'John Doe')
          .withAttribute('email', 'john.doe@example.com')
          .make();
      expect(user, isA<User>());
      expect(user.name, 'John Doe');
      expect(user.email, 'john.doe@example.com');
    });

    test('Should create a user with name and email 2', () {
      final user = UserFactory({
        'name': 'John Doe',
        'email': 'john.doe@example.com',
      }).make();
      expect(user, isA<User>());
      expect(user.name, 'John Doe');
      expect(user.email, 'john.doe@example.com');
    });

    test('Should create a user with name and email 3', () {
      final user = UserFactory({
        'name': 'John Doe',
      }).withAttribute('email', 'john.doe@example.com').make();
      expect(user, isA<User>());
      expect(user.name, 'John Doe');
      expect(user.email, 'john.doe@example.com');
    });

    test('Should create a user with name and email 4', () {
      final user = UserFactory({
        'name': 'John Doe',
      }).withEmail('john.doe@example.com').make();
      expect(user, isA<User>());
      expect(user.name, 'John Doe');
      expect(user.email, 'john.doe@example.com');
    });

    test('attributes with withAttribute takes higher precedence', () {
      final user = UserFactory({
        'name': 'John Doe',
        'email': 'john.doe@example.com',
      }).withAttribute('email', 'john.doe@example.org').make();
      expect(user, isA<User>());
      expect(user.name, 'John Doe');
      expect(user.email, 'john.doe@example.org');
    });

    test('attributes with withAttribute takes higher precedence', () {
      final user = UserFactory()
          .apply(
            (user) => user.copyWith(
              name: 'John Doe',
              email: 'john.doe@example.com',
            ),
          )
          .withAttribute('email', 'john.doe@example.org')
          .make();
      expect(user, isA<User>());
      expect(user.name, 'John Doe');
      expect(user.email, 'john.doe@example.org');
    });

    test('User should have a valid email', () {
      final user = UserFactory().make();
      expect(user, isA<User>());
      expect(user.email, isA<String>());
      expect(user.email, contains('@'));
    });

    test('User can be created with merchant', () {
      final user = UserFactory()
          .withMany(
            PostFactory().withMany(CommentFactory(), 20),
            1,
          )
          .make();
      expect(user, isA<User>());
      expect(user.email, isA<String>());
      expect(user.email, contains('@'));
      expect(user.posts, isA<List>());
      expect(user.posts!.length, 1);
      expect(user.posts!.first, isA<Post>());
      expect(user.posts!.first.comments, isA<List>());
      expect(user.posts!.first.comments!.length, 20);
    });
  });
}
