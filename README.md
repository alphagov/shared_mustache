# SharedMustache

Add the ability to share [mustache][mustache] templates in Rails and
JavaScript.

Mustache templates will be rendered using Ruby mustache on the server.

On the client there is a jQuery helper to let you use the template. In
development the templates are outputted on the page in script blocks. For
production the templates are compiled using [hogan.js][hogan], the compiled
templates can then be included into your standard JavaScript file using the
asset-pipeline.

## Installation

Add 'shared_mustache' to your your application's Gemfile.

By default when you run `rake shared_mustache:compile` it will put the outputed
templates JavaScript at `Rails.root/app/assets/javascript/templates.js`. This
can be configured using an intializer. The `templates.js` file should be kept
empty for development and only populated in production.

You should add the following lines to your `application.js`:

    //= require shared_mustache
    //= require templates

This adds the jQuery helper for you to use the templates and in production will
add the compiled templates.

At the bottom of your main layout you should add:

    <%= render_mustache_templates if Rails.env.development? %>

Add `rake shared_mustache:compile` before the `assets:precompile` step of your
deploy script.

Currently it expects your views to be found under `app/views`.

## Usage

Create mustache templates as you would erb partials. So for example at
`app/views/home/_row.mustache`. You can then render it in an `erb` template
using:

    <%= render_mustache('home/row', context) %>

It tries to use the same conventions as the native render methods. Such that
you can ommit the controller if the mustache is in the same folder as the
currently executing controller.

In your JavaScript you should get access to jQuery methods to interact with the
mustache templates:

    $.mustache('home/_row', context);


[mustache]: http://mustache.github.io/
[hogan]: http://twitter.github.io/hogan.js/
