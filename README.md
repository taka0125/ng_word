# NgWord

[![Latest Version](https://img.shields.io/gem/v/ng_word.svg)](https://rubygems.org/gems/ng_word)
[![Build Status](https://github.com/taka0125/ng_word/workflows/Ruby/badge.svg)](https://github.com/taka0125/ng_word/actions)

Verify NG words.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ng_word'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ng_word

## Usage

```ruby
rule_list = NgWord::RuleList.new([
  NgWord::Rule.new('ng', exclude_words: ['ng word']),
  NgWord::Rule.new('hoge')
])

text = "This text is include NG word and hoge word."
result = rule_list.verify(text)
rule_list.match?(text)
masked_text = rule_list.masked_text(text)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Code Status

[![CircleCI](https://circleci.com/gh/taka0125/ng_word/tree/master.svg?style=svg)](https://circleci.com/gh/taka0125/ng_word/tree/master)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/taka0125/ng_word.
