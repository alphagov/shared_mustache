# SharedMustache

Add the ability to share [mustache][mustache] templates in Rails and
JavaScript. They will be compiled using [hogan][hogan] for production and
then compiled into your JavaScript using the asset-pipeline.

In development they will be rendered into script blocks on the page.

## Installation

Add 'shared_mustache' to your your application's Gemfile.

By default when you run `rake shared_mustache:compile` it will put the outputed
templates JavaScript at `Rails.root/app/assets/javascript/templates.js`. This
can be configured using an intializer.

You should add the following lines to your `application.js`:

    //= require shared_mustache
    //= require templates

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


