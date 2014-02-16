# TINAMI

[![Build Status](https://travis-ci.org/mitukiii/tinami-for-ruby.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/mitukiii/tinami-for-ruby.png)][codeclimate]
[![Dependency Status](https://gemnasium.com/mitukiii/tinami-for-ruby.png?travis)][gemnasium]

[travis]: https://travis-ci.org/mitukiii/tinami-for-ruby
[codeclimate]: https://codeclimate.com/github/mitukiii/tinami-for-ruby
[gemnasium]: https://gemnasium.com/mitukiii/tinami-for-ruby

TINAMI is a simple TINAMI API library

## Installation

Add this line to your application's Gemfile:

    gem 'tinami'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tinami

## Usage

```ruby
TINAMI.configure do |config|
  config.api_key = 'YOUR_API_KEY'
end

auth = TINAMI.auth('YOUR_EMAIL', 'YOUR_PASSWORD')
auth_key = auth.auth_key
client = TINAMI.new(auth_key: auth_key)

info = client.info
info.user # => {no: "146005"}

ranking = client.ranking(1)
ranking.contents.content.each do |content|
  # ... do something
end

search = client.search(text: '艦これ')
search.contents.content.each do |content|
  # ... do something
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2014 [Kazuya Takeshima](mailto:mail@mitukiii.jp). See [LICENSE][license] for details.

[license]: LICENSE.md
