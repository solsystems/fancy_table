fancy_table
===========

Tables. Done right.

![fancy_table of Firefly episodes](https://github.com/calebthompson/fancy_table/raw/master/firefly-episodes.png)

What's going on here?
---------------------

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
  @users = User.all
  @headers = {
    # This one's an instance method on User
    full_name: 'Name',
    # This one's a column on the User table
    created_on: 'Since',
    # Also a column. You can pass either a string or a symbol. We're not picky.
    'age' => 'Age',
    # This one's a method on a relation (User has_many :posts)
    'posts.count' => 'Number of Posts',
  }
end
```

### _Then in a view:_

```haml
%section#user-index-page
  = fancy_table 'All my Users', @users, @headers
```  

What if I want to do...
-----------------------

We've probably got you covered. Let's take a look at the optional arguments for
`build_fancy_table` and their default values.

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

### Pagination

Pagination currently requires the kaminari gem.

You can turn off pagination entirely if you would like:

```ruby
paginate: false
```

Otherwise, there are several options to customize pagination.

#### rows_per_page_options

Specify the collection of options for the number of rows to show on a single
page.

The format is (this is also the default setting):

```ruby
rows_per_page_options: [10, 25, 50, 'All']
```

Where 'All' is the only valid non-numeric option and works as expected.

#### show_rows_per_page

The rows per page setting will only appear when the number of displayed rows
is less than or equal to ten.

TODO: Make this less than the lowest option in `rows_per_page_options`

You can specify that you do not want one at all:

```ruby
show_rows_per_page_select: false
```

### Full Row Select
  
  # Do you want to be able to click on rows to expand them and show hidden
  #   content?†
  # If so, point us to the partial you would like to render in the detail row.
  # This will be whatever you'd pass to `render partial: ...`
}
```



### Full Row Select

Do you want to be able to click on rows to expand them and show hidden content?

Using [calebthompson](https://github.com/calebthompson)'s
[full-row-select](https://github.com/calebthompson/full-row-select) (which
you'll have to download and install seperately), you can allow users to click on
a row in the fancy_table and have it expand to show a 'detail row'.

Demos are often better than words, so go over
[here](http://www.jankoatwarpspeed.com/examples/expandable-rows/)
if you don't understand.

To use full row select, tell fancy_table which partial to render:

```ruby
full_row_select_partial: inline_post
```

The partial will be rendered in a `<tr>` after the parent `<tr>`, and the detail
`<tr>` will be hidden by the full-row-select JavaScript.

The fancy_table will be given the `.collapsible` class of
`full_row_select_partial` is specified. You will need to style this seperately
if you want any sort of indicator for expandible tables (such as a ▶/▼ toggle)
or to preserve alternating background row colors.

I don't like how it looks.
--------------------------

Sticks and stones, friend.

While we've included styles for fancy_table, we encourage you to roll your own
that match your site. It will probably turn out better for you in the long run
if you design your own look‐and‐feel.

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
