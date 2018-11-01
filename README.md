# Curator

Curator is an ePub parser library that wraps ebooks in a nice DSL.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'curator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install curator

## Usage

Curate an epub file into a `Book` ruby object

```ruby
require 'curator'

epub_file = '/Users/tylerferraro/books/wizard-of-oz.epub'
book = Curator.curate(epub_file)
puts book.info

#=> Title: Wizard of Oz
#   Authors: L. Frank Baum
#   Publication: 1996-02-01
#   Subjects: Fantasy literature, Magic -- Juvenile fiction, ...
#   Language: English
#   Rights: Public domain in the USA
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerferraro/curator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
