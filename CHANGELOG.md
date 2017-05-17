# 1.0.1

* Add hogan.js to assets.precompile for compatibility with sprockets-rails 3.x

# 1.0.0

* Bump mustache to 1.0.2. This requires Ruby 2.0 or higher.

# 0.2.1

* Remove `typeof exports` check in Hogan libraries: https://github.com/alphagov/shared_mustache/pull/8.

# 0.2.0

* shared_mustache no longer ships with a blank template.js file. Any apps using shared_mustache will now need to ensure they have their own template.js and that it is checked in to the source.
