# Operator Frog 🐸

## What is Operator Frog

Operator Frog is a `< 24h` thought experiment that I did. I wanted to know if we could write a strange looking API in Dart for HTTP communication without needing any kind of code generation.

## How does it work?

Operator Frog overwrites operators to create an API that does not depend on methods. This doesn't make it readable (unless you are me) but it is a nice showcase of how you can overwrite operators in Dart and that certain kind of operators (bit-wise vs comparators) have a certain logic when it comes to their return type.

For instance any bit-wise operator (`&`, `^`, `|`, `>>`, `<<<`) in Dart will allow to directly chain the next bit-wise operator without having to put the statement in parentheses. While the comparator operators (`>=`, `>`) will assume that the next operator is called on the left side of the previous operator call. 

This mean there is a certain restriction in how you can define chained API logic. For instance with the client from Operator Frog you can do the following:

```dart
final client = http > 'http://localhost:8080';

await (client.post / 'todos' &
  header >> {'Content-Type': 'application/json'} &
  json >> {'title': 'A new Todo'});
```

Notice how we are using `>>` and `&` to setup our request object? If instead of `>>` we used `>` it would complain that `The operator '>' isn't defined for the type 'HttpRequest'.` because the `>` is being called on the result of `client.post / 'todos & header` and not on `header`.

### Readability

I tried to remain some form of readability on both the client and server side by using specific operators for specific actions. For instance the action to create a request (or define a route on the server) I used the `/` operator, indicating the start of a path: `/some/path`.

If something needs to be added to an object, like adding a header or a query to `HttpRequest` I used the `&` operator, indicating `this with that` or `this and that`. 

And then if we wanted to set the final value, like the route executor or the final value of a `body` I used the `>>` operator, which should be read as `this uses that`.

On the server side I decided to use the `|` to chain routes or middleware. As only route can ever be triggered for a single request it should be read as `this or that`.

To facilitate these operators the server and client packages both provide certain constant values that have these operators defined:
- Server
  - `middleware > (Handler) => Handler`: to define a new middleware handler
  - `METHOD / 'path' >> (RequestContext) => Response`: where `METHOD` is one of the provided HTTP method constants, `get`, `post`, `put`, `patch`, `delete`, `head`, `options`
- Client
  - `http > 'http://host:port'`: to create a new client
  - `client.METHOD / 'path'`: to create a new http request that is also future-able. 
  - `request & RequestAttribution`: to add an attribution like `body`, `json`, `query` or `header`.
  - `RequestAttribution >> dynamic`: to set the value of a specific attribution. 

## What now?

Nothing, honestly this shouldn't ever be used in any form or sense as it is not readable and there are probably a lot of caveats and issues with this approach that I didn't even think off. 

If anything this should serve as a reminder that it is okay to stray of the "correct" path and do some exploration yourself, at best you will find a cool concept and at it's worse you might learn something new.

## Credits & Gratitude

I would like to give gratitude for the existence of [Dart Frog](https://dartfrog.vgv.dev), which was used to build this API.

And I would like to give a shout-out to [Felix Angelov](https://github.com/felangel) for tolerating (and debugging) this thought experiment.