import 'package:faker/faker.dart';
import 'package:fixture_factory/fixture_factory.dart';

import '../models/user.dart';

class UserFactory extends FixtureFactory<UserFactory, User> {
  UserFactory([super.attributes]);

  var faker = Faker();

  @override
  User definition() {
    return User(
      id: faker.randomGenerator.integer(10000),
      name: faker.person.name(),
      email: faker.internet.email(),
      mobile: faker.phoneNumber.toString(),
      dateOfBirth: faker.date.dateTime(),
      posts: [],
      comments: [],
    );
  }

  UserFactory withName(String name) =>
      apply((user) => user.copyWith(name: name));

  UserFactory withEmail(String email) => withAttribute("email", email);

  @override
  User fromJson(Map<String, dynamic> json) => User.fromJson(json);
}
