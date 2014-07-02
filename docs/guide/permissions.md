# Faalis Permissions
**Faalis** contains a full fledged users permission system using
`cancan` gem. **Faalis** adds `read`, `update`, `create`, `destroy`
permissions to objects you choose and authorize users access to that
object by `cancan` gem. Of course you can edit these default permissions
of add others too.

**Faalis** subsystems are aware of permissions and authorize user access to
any object you specified.

**Faalis** implemented a Rails `concern` which adds supports for
**permissions** to a model or any class which you want to use permissions
for it. For example:

```ruby
class Person < ActiveRecord::Base
  include Faalis::Concerns::Authorizable
  # rest of your model
end
```
**Note**: It previous versions of **Faalis** `<= 0.26.3`, `Faalis::Concerns::Authorizable`
automatically included in any `ActiveRecord::Base`. But since it wasn't a good
idea we fixed it.

Now take a look at a **Mongoid** example:

```ruby
class Person
  include Mongoid::Document
  include Faalis::Concerns::Authorizable
end
```
As you can see we just added `Faalis::Concerns::Authorizable` to a simple class.

## User & Group
`Faalis::User` is the user model which has a many to many relation with
`Faalis::Group` (Note: If your using **Mongoid** or any other non-relational
mappers, then you should know that `Faalis::User` embeds many `Faalis::Group`)

Each `Faalis::Group` has many (embeds many)  permissions and **Faalis** authorize user access
by groups which user is member of.
