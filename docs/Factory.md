# Fixture Factory
`FixtureFactory` is a class that allows you to create fixtures for testing.

## Usage

### Creating a FixtureFactory
A `FixtureFactory` has to be created for each model that you want to create fixtures for.
Say you want to create fixtures for a `User` model, you can create a `UserFactory` for the
`User` model as follows

```dart
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

   @override
   User fromJson(Map<String, dynamic> json) => User.fromJson(json);
}
```

Once a factory is created, you can use it like so.

```dart
final user = UserFactory().make();
```

If you want to create multiple models,

```dart
final user = UserFactory().makeMany(100);
```


#### Adding Modifiers
A modifier is a method that allows you to add specific attributes to a fixture.
There are 2 types of modifiers you can add to a [FixtureFactory]

##### JSON Modifiers

1. You can add attributes directly to the constructor

   ```dart
       final user = UserFactory({
       'name': 'John Doe',
       'age': 20,
       }).make();
   ```

2. You can add attributes using the `withAttribute` and `withAttributes` methods

   ```dart
    final user = UserFactory()
        .withAttribute('name', 'John Doe')
        .withAttribute('age', 20)
        .make();
   ```

   or

   ```dart
   final user = UserFactory()
   	.withAttributes({
   		'name': 'John Doe',
   		'age': 20,
   	})
   	.make();
   ```

   You can also add these modifiers to the factory directly

   ```dart
   FixtureFactory<User> withEmail(String email) {
     return withAttribute("email", email);
   }   
   ```

##### Model Modifiers

Model Modifiers are added using the `apply` method

```dart
final user = UserFactory()
    .apply(
      (user) => user.copyWith(
        name: 'John Doe',
        email: 'john.doe@example.com',
      ),
    )
    .make();
```

You can also add these modifiers to the factory directly

```dart
FixtureFactory<User> withName(String name) {
  return apply((user) => user.copyWith(name: name));
}
```

##### Example of using modifiers

```dart
final user = UserFactory()
    .apply(
      (user) => user.copyWith(
        name: 'John Doe',
        dateOfBirth: DateTime(1990, 1, 1),
      ),
    )
    .withAttribute('email', 'john.doe@example.org')
    .make();
```

```dart
final user = UserFactory()
    .withName('John Doe')
    .withAge(20)
    .make();
```

#### Relationships

If there is a relationship between models, you can create a fixture for
a model with a relationship by passing in a `Map<String, dynamic>` to the `UserFactory` constructor.

```dart

final user = UserFactory({
  'name': 'John Doe',
  'age': 20,
  'posts': PostFactory().makeManyJson(3),
}).make();
```

If you want to create a fixture for a model with a relationship, you can
also use the generic `withOne<T>` or `withMany<T>` methods.

```dart

final user = UserFactory()
    .withName('John Doe')
    .withAge(20)
    .withMany<Post>(PostFactory(), 3)
    .withOne<Address>(AddressFactory())
    .make();
```

#### Sequences

You can use sequences to create models with varying data.

```dart
var users = UserFactory()
    .sequence(Sequence<JSON>([
      {"name": "John Doe"},
      {"name": "Jane Doe"},
      {"name": "Johnny"},
    ]))
    .makeMany(10);
```

This will create
- 3 users with name "John Doe"
- 3 users with name "Jane Doe"
- 4 users with name "Johnny"

You can combine multiple sequences to create complete data easily.

```dart
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
    .makeMany(10);
```

The resulting 10 users will be created with following data
- Users 1-3: Name: "John Doe", Mobile: "1234567890"
- Users 2-5: Name: "Jane Doe", Mobile: "1234567890"
- User 6:  Name: "Jane Doe", Mobile: "0987654321"
- Users 7-10 Name: "Johnny", Mobile: "0987654321"
