fancy_table
===========

Tables. Done right.

![fancy_table of Firefly episodes](https://github.com/calebthompson/fancy_table/raw/master/firefly-episodes.png)

What's going on here?
---------------------

fancy_table allows you to easily create tables which are semantic HTML5, are
easy to style, and are beautiful.

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

```ruby
{
  # Actions appear in the fancy_table's caption as links.
  # Format is { "Link text" => path }
  # Useful for things like creating a new entry.
  actions: {},

  # Member Actions appear in the same row as the model.
  # For simple actions, the format is { text => controller_action }
  #   These will be rendered as "#{controller_action}_#{table_name}_path"
  # For more complicated things, you can pass a block as the value.
  # It should return a link.
  # Useful for things like editing or destroying entries.
  member_actions: {},

  # Group Actions appear as links in the table's footer and cause fancy_table
  #   to add checkboxes to each row.
  # These are useful for bulk updates to entries.*
  group_actions: [],

  # This is the controller which will be used to perform group actions.*
  update_multiple_controller: (controller.controller_name),

  # What options would you like for the select box for how many rows should be
  #   shown on each page?
  rows_per_page_options: [10, 25, 50, 'All'],

  # Would you even like to have a rows_per_page select box?
  show_rows_per_page_select: (rows.size > 10),

  # Would you even like pagination?
  # We won't actually paginate if there are less than params[:rows_per_page]
  #   rows.
  paginate: true,
  
  # Do you want to be able to click on rows to expand them and show hidden
  #   content?†
  full_row_select: '
}
```

###* Using group actions

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

###<sup>†</sup> Full Row Select

Using calebthompson's [full-row-select](https://calebthompson/full-row-select)

Smart Order
-----------

We love you...
--------------

...and want you to be happy.

If you have any problems with fancy_table, please
[open an issue](https://github.com/solsystems/fancy_table/issues/new) and we'll
see if we can help out.

We'd love you more even more if you forked fancy_table and
[opened a pull request](https://github.com/solsystems/pull/new) instead.
