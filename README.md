# Common Rails code, layouts, partials, css and javascript for DTU Library

Deals mostly with providing a layout that expresses the layout and styling
according to the DTU Style Manual and that mimicks the structure and visuals of
the official DTU homepage at http://www.dtu.dk.

Also provides some authentication related functionality involving configuring
devise/omniauth/omniauth-cas to authenticate against the DTU Library User
Database and post-authentication extracting additional user infomation from the
DTU Library User Database rest api.

## How do I add it to my application?

* Add to your Gemfile
  ```
  gem 'dtu_rails_common', :github => 'dtulibrary/dtu_rails_common'
  ```

* Install the gem
  ```
  $ bundle install
  ```

## How do I use it

### Layout and styling

By default the gem does not add anything to the application (apart from
dependencies on e.g. bootstrap, etc.). To use the layout and css from the gem
you will have to

* add the line below somewhere early (e.g. before blacklight) in
  `app/assets/stylesheets/application.css.scss` (or another appropriate `.scss`
  file):

        @import 'dtu_rails_common';

* add the line below somehere early in app `assets/javascripts/application.js`:

        //= require 'dtu_rails_common'

To use the layout you will probably want to apply what is called a [nested
layout](http://guides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts).
I.e. you create a layout, say `app/views/layouts/application.html.erb`, that
sets up the content for the 5 placeholders `:head:`, `:logo`, `:masthead`,
`:modals`, and `:menu`.

Example:
```
<% content_for :head do %>
<!-- this goes into /html/head -->
<% end %>

<% content_for :menu do %>
<!-- this goes into the top right corner of the application. Useful for application menus and login/logout -->
<% end %>

<% content_for :logo do %>
<!-- this goes into the left part on the "fat" header -->
<% end %>

<% content_for :masthead do %>
<!-- this goes into the center part (to the right of the :logo) of the fat header -->
<% end %>

<% content_for :modal do %>
<!-- this is a place to define modals and other hidden stuff that is needed by the application -->
<% end %>


<%= render template: "layouts/dtu" %>
```

## Authentication (Unfinished)

The gem provides an omniauth-cas controller that post-authentication queries the
DTU Library User Database for additional user information such as data from
DTUBasen and the user's roles in relation to other DTU Library applications. To
take advantage of this authentication functionality the application must to
provide

* a user model (`User`) configured with
  ```
  devise :trackable, :omniauthable

  serialize :user_data, JSON
  ```

  and attributes

  ```
  t.string   :identifier,        null: false
  t.text     :user_data,         null: false

  t.string   :email,             null: false, default: ""

  ## Devise Trackable
  t.integer  :sign_in_count,     null: false, default: 0
  t.datetime :current_sign_in_at
  t.datetime :last_sign_in_at
  t.string   :current_sign_in_ip
  t.string   :last_sign_in_ip
  ```

If your application already utilizes Devise (e.g. a Blacklight or Worthwhile
based app) all but the first two attributes will be present on the `User` model
already. Adding the two remaining attributes can be done by

```
$ bundle exec rails g migration AddIdentifierAndUserDataToUsers identifier:text:uniq user_data:text:text
```

## Running the tests

```
rm -rf spec/internal
bundle exec rake engine_cart:generate
bundle exec rspec
```
