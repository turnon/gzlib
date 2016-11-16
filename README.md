# Gzlib

search books on http://opac.gzlib.gov.cn/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gzlib'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gzlib

## Usage

Search for title on CLI:

    $ gzlib metarogramming

More condition in ruby script:

```ruby
Gzlib::Search.isbn 9787560974583
```

