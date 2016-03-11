# Polymorph

## 1. Installation

### 1.1 Add Gemfile

```ruby
# Gemfile

gem 'polymorph'
```

### 1.2 Mount Engine

```ruby
# config/routes.rb
# Rails.application.routes.draw do

  mount Polymorph::Engine, at: '/'

# end
```

### 1.3 Initializer to help with authentication

If you skip it anybody could use new functions.

```ruby
# ininitalizers/polymorph.rb

Polymorph.configure do |config|
  config.authorize = lambda do |controller|
    controller.authenticate_user!
  end
end
```

## 2. Orderable

Orders models on their position column via `ordered` scope. If you are using it
you would have to add some additional dependencies:

### Orderable Dependencies

`Orderable` user drag-n-drop depends on jQuery UI.

```ruby
# Gemfile

gem 'jquery-ui-rails'
```

It also needs some js helpers:

```javascript
# application.js
//= require jquery-ui/sortable
//= require polymorph/polymorph
```

And an optional stylesheet for changing cursor shape:

```css
/*  application.css
 * = require polymorph
 */
```

Default selector is `.admin [data-orderable]` so you have to add `.admin`
class somewhere for an authorized user.

```slim
body class=(current_user.admin? && 'admin')
```

Orderable items got to have its `#id` in HTML `id` element

```
div_for(model)
```
or
```
div id=dom_id(model)
```

### Orderable Installation.

Add `position:integer` to a model schema

```sh
rails g migration add_position_to_model position:integer
rake db:migrate
```

Include `Polymorph::Orderable` in the `Model` class

```ruby
# models/model.rb
# class Model < ActiveRecord::Base

  include Polymorph::Orderable

# end
```

Don't forget to use `ordered` scope

```ruby
# controllers/models_controller.rb
def index
  @models = Model.ordered
end
```

HTML selector

```slim
# index.html.slim

div data-orderable=polymorph.orderable_path(Model)
  = render @models
```

### Additional Orderable Parameters:

**Axis** limits movement alone X or Y axes:

```slim
data-orderable-axis="y"
```

**Items** is an additional subselector for items that will be serialized and moved:

```slim
data-orderable-items="> .block"
```

## 3. Paranoid

This module provides paranoid delete akin to
[Paranoia](http://github.com/radar/paranoia) gem. But there is one important
difference. There are no callbacks.

It simply updates `deleted_at` so you can restore deleted entries with
associations associations intact.

First create a migration:

```ruby
rails generate migration AddDeletedAtToModel deleted_at:datetime:index
rake db:migrate
```

Add concern to model:

```ruby
# models/model.rb
# class Model < ActiveRecord::Base

  include Polymorph::Paranoid

# end
```

You need to add `Polymorph::Application` helper to Application Controller.

```ruby
# controllers/application_controller.rb
# class ApplicationController < ActionController::Base

  helper Polymorph::ApplicationHelper

# end
```

Included module sets up `default_scope` so soft-deleted entries are skipped.
Additional class method `paranoid_destroy` is added to the parent class in case
you want to wrap your own stuff.

```
# controllers/model_controller.rb
# def destroy

  @model.paranoid_destroy

# end
```

## 4. Publishable

This one sets `published_at` in the same vein as with Paranoid.

First a migration:

```
rails generation migration AddPublishedAtToModel published_at:datetime:index
rake db:migrate
```

Add concern:
```
include Polymorph::Publishable
```

This module adds 'published' and 'unpublished' scope.
