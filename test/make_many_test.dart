import 'package:test/test.dart';

import 'factories/user_factory.dart';

void main() {
  test('When we make many, all values are unique', () {
    var users = UserFactory().makeMany(10);
    var uniqueIds = users.map((e) => e.id).toSet();
    expect(uniqueIds.length, 10);
    var uniqueNames = users.map((e) => e.name).toSet();
    expect(uniqueNames.length, 10);
  });

  test("When we make many, but set a specific value, it's set", () {
    var users = UserFactory({
      "name": "John Doe",
    }).makeMany(10);
    var uniqueNames = users.map((e) => e.name).toSet();
    expect(uniqueNames.length, 1);
    expect(uniqueNames.first, "John Doe");
    var uniqueIds = users.map((e) => e.id).toSet();
    expect(uniqueIds.length, 10);
  });

  test("When we make many and set value through apply, it's set", () {
    var users = UserFactory().apply((u) {
      return u.copyWith(name: "John Doe");
    }).makeMany(10);
    var uniqueNames = users.map((e) => e.name).toSet();
    expect(uniqueNames.length, 1);
    expect(uniqueNames.first, "John Doe");
    var uniqueIds = users.map((e) => e.id).toSet();
    expect(uniqueIds.length, 10);
  });

  test("When we make many and set value through apply, it's set", () {
    var users = UserFactory()
        .apply((u) {
          return u.copyWith(name: "John Doe");
        })
        .withAttribute('name', "Johnny")
        .makeMany(10);
    var uniqueNames = users.map((e) => e.name).toSet();
    expect(uniqueNames.length, 1);
    expect(uniqueNames.first, "Johnny");
    var uniqueIds = users.map((e) => e.id).toSet();
    expect(uniqueIds.length, 10);
  });

  test(
      "When we make many and set value through apply after set value with attributes, it's set",
      () {
    var users = UserFactory()
        .withAttribute("name", "John Doe")
        .apply((u) {
          return u.copyWith(email: "Johnny@example.com");
        })
        .withAttribute('mobile', "1234567890")
        .makeMany(10);

    var uniqueNames = users.map((e) => e.name).toSet();
    expect(uniqueNames.length, 1);
    expect(uniqueNames.first, "John Doe");

    var uniqueEmails = users.map((e) => e.email).toSet();
    expect(uniqueEmails.length, 1);
    expect(uniqueEmails.first, "Johnny@example.com");

    var uniqueMobiles = users.map((e) => e.mobile).toSet();
    expect(uniqueMobiles.length, 1);
    expect(uniqueMobiles.first, "1234567890");
  });

  test(
      "When we make many and set value through apply after set value with attributes",
      () {
    var users = UserFactory().withAttribute("name", "John Doe").apply((u) {
      return u.copyWith(name: "Johnny");
    }).makeMany(10);

    var uniqueNames = users.map((e) => e.name).toSet();
    expect(uniqueNames.length, 1);
    expect(uniqueNames.first, "Johnny");
  });
}
