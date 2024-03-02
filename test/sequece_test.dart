import 'package:test/test.dart';
import 'package:fixture_factory/fixture_factory.dart';

import 'factories/post_factory.dart';
import 'factories/user_factory.dart';
import 'models/user.dart';

void main() {
  test("User Factory can use sequence", () {
    var users = UserFactory()
        .sequence(Sequence<JSON>([
          {"name": "John Doe"},
          {"name": "Jane Doe"},
        ]))
        .withMany(PostFactory(), 2)
        .makeMany(10);

    expect(users.length, 10);
    var first5 = users.sublist(0, 5);
    var first5Names = first5.map((user) => user.name).toSet();
    expect(first5Names.length, 1);
    expect(first5Names.first, "John Doe");

    var last5 = users.sublist(5, 10);
    var last5Names = last5.map((user) => user.name).toSet();
    expect(last5Names.length, 1);
    expect(last5Names.first, "Jane Doe");
  });

  test("User Factory can use sequence 2", () {
    var users = UserFactory()
        .sequence(Sequence<JSON>([
          {"name": "John Doe"},
          {"name": "Jane Doe"},
          {"name": "Johnny"},
        ]))
        .withMany(PostFactory(), 2)
        .makeMany(10);

    expect(users.length, 10);
    var first3 = users.sublist(0, 3);
    var first3Names = first3.map((user) => user.name).toSet();
    expect(first3Names.length, 1);
    expect(first3Names.first, "John Doe");

    var second3 = users.sublist(3, 6);
    var second3Names = second3.map((user) => user.name).toSet();
    expect(second3Names.length, 1);
    expect(second3Names.first, "Jane Doe");

    var last4 = users.sublist(6, 10);
    var last4Names = last4.map((user) => user.name).toSet();
    expect(last4Names.length, 1);
    expect(last4Names.first, "Johnny");
  });

  test("Multiple sequences can be added", () {
    var users = UserFactory()
        .sequence(Sequence<JSON>([
          {"name": "John Doe"},
          {"name": "Jane Doe"},
          {"name": "Johnny"},
        ]))
        .sequence(
          Sequence.apply<User>([
            (u) => u.copyWith(mobile: "1234567890"),
            (u) => u.copyWith(mobile: "0987654321"),
          ]),
        )
        .withMany(PostFactory(), 2)
        .makeMany(10);

    expect(users.length, 10);
    var first3 = users.sublist(0, 3);
    var first3Names = first3.map((user) => user.name).toSet();
    expect(first3Names.length, 1);
    expect(first3Names.first, "John Doe");

    var second3 = users.sublist(3, 6);
    var second3Names = second3.map((user) => user.name).toSet();
    expect(second3Names.length, 1);
    expect(second3Names.first, "Jane Doe");

    var last4 = users.sublist(6, 10);
    var last4Names = last4.map((user) => user.name).toSet();
    expect(last4Names.length, 1);
    expect(last4Names.first, "Johnny");

    /// Sequence test age
    var first5 = users.sublist(0, 5);
    var first5Mobile = first5.map((user) => user.mobile).toSet();
    expect(first5Mobile.length, 1);
    expect(first5Mobile.first, "1234567890");

    var last5 = users.sublist(5, 10);
    var last5Mobile = last5.map((user) => user.mobile).toSet();
    expect(last5Mobile.length, 1);
    expect(last5Mobile.first, "0987654321");
  });
}
