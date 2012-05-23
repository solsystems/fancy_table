fancy_table
===========

Tables. Done right.

BOOM!
-----

```erb
<%= fancy_table @firefly_episodes %>
```

![fancy_table of Firefly episodes](https://github.com/calebthompson/fancy_table/raw/master/firefly-episodes.png)

Okay, you've piqued my interest. What's going on here?
-------------------------------------------

fancy_table allows you to easily turn an ActiveRecord::Relation into a semantic
HTML5 table which supports sorting, pagination, and links for actions to be
posted back to the controller.

Besides automagic generation of the table from the ActiveRecord::Relation, the
killer feature is probably sorting on the server-side (_read: vroom!_).
This is done by clicking on headers and uses SmartOrder (see below).

If it's so easy, how do I do it?
--------------------------------

Great question. A lot of effort was put into making the developer—that's
you—happy. To that end, much of fancy_table's syntax had been wrapped into two
calls.

### _In the controller:_

```ruby
def index
  @firefly_episodes = FireflyEpisode.scoped
  @firefly_episodes = build_fancy_table @firefly_episodes
end
```

### _Then in a view:_

```haml
= fancy_table @firefly_episodes
```  

What if I want to do...
-----------------------

We've probably got you covered. Let's take a look at the optional arguments for
`build_fancy_table` in the controller, and their default values.

### actions

Actions appear in the fancy_table's `<caption>` as links. Actions are useful
for things which do not relate to specific objects, such as creating a new
entry.

The format fairly simple:

```ruby
actions: { "Link text" => path }
```

### member_actions

Member Actions appear as links in the row with the model in the last `<td>`.
These should be used for object-specific actions, such as edit or delete.

Simple actions can be formatted similarly to the `actions` option above:

```ruby
member_actions: { "edit" => :edit }
```

Which will render a link to `edit_model_path`.

You can also pass a block as the value for more complicated actions:

```ruby
member_actions: { "complicated" => block_of_code }

def block_of_code(member)
  # Return a URL
end
```

By default there are no member_actions.

### group_actions

Group actions are a little different than the other options. They require a
method on the `update_multiple_controller` (this option defaults to the
controller displaying the fancy_table, so most of the time you're probably set)
called `update_multiple`. Let's take a look at what that should look like.

```ruby
def update_multiple
  @models = Model.find(params[:model_ids])
  case params[:commit] # params[:commit] will contain the group_action
  when group_actions[0] # You'd probably have something like 'Approve Selected'
                        #   or 'Delete Selected' here
    @models.each do |model|
      # Do whatever is required for this group action
  when group_actions[n]
    @models.each do |model|
      # Do whatever is required for this group action
  end
  # redirect to wherever you'd like your user to go next
end
```

You can set a custom update multiple controller:

```ruby
update_multiple_controller: UpdateMultipleController
```

The format for group_actions is:

```ruby
group_actions: [:delete, :approve, :etc]
```

### limit

The number of rows to show on the fancy_table at a time. Pagination will be
added to the `<footer>` if neccessary.

Pagination magic provided by [kaminari](https://github.com/amatsuda/kaminari)

I don't like how it looks.
--------------------------

Sticks and stones, friend.

While we've included styles for fancy_table, we encourage you to roll your own
that match your site. It will probably turn out better for you in the long run
if you design your own look‐and‐feel.

We customized the styles for fancy_table for our own site. Here is what the
previous table would look like for us:

![fancy_table of Firefly episodes](https://github.com/calebthompson/fancy_table/raw/master/firefly-episodes.png)

SmartOrder
----------

The heavy lifting of sorting fancy_tables is done server-side in the model.
To accomplish this, we include the SmartOrder module in our models.

You have a couple of options here. If you plan to use fancy_table extensively
through your application, you can include SmartOrder in ActiveRecord::Base in
an initializer:

```ruby
class ActiveRecord::Base
  include SmartOrder::Sortable
end
```

If you are only going to use fancy_table in one or two places—or if you don't
like the idea of extending Rails core classes, you can include it in specific
models as well:

```ruby
class Book < ActiveRecord::Base
  include SmartOrder::Sortable
  # The rest of your model code
end
```

We plan to pull smart_order out into its own gem down the road, but we were more
excited about fancy_table so we started here.

Our own dog food
----------------

We use fancy_table extensively in our solar project finance platform,
[SolMarket](http://solmarket.com), and plan to use it in the Rails rewrite of
our other site, [SolSystems](http://solsystemscompany.com).

We love you...
--------------

...and want you to be happy.

If you have any problems with fancy_table, please
[open an issue](https://github.com/calebthompson/fancy_table/issues/new) and
we'll see if we can help out.

We'd love you more even more if you forked fancy_table and
[opened a pull request](https://github.com/calebthompson/fancy_table/pull/new)
instead.
