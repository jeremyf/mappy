# Mappy [![Build Status](https://travis-ci.org/jeremyf/mappy.png?branch=master)](https://travis-ci.org/jeremyf/mappy)

Map one object to another.

## Installation

Add this line to your application's Gemfile:

    gem 'mappy'

And then execute:

    $ bundle

Or install it yourself:

    $ gem install mappy

## Usage

You can certainly read the documentation. In particular the [Mappy module](lib/mappy.rb).
But if you are like me, you won't trust the documentation.
Instead I would recommend reading the specs, especially [mappy_spec](spec/mappy_spec.rb)

### TL;DR

```ruby
  class Book
    attr_accessor :name, :authors
    def initialize(attributes = {})
      attributes.each {|key, value| send("#{key}=", value) if respond_to?("#{key}=") }
    end
  end

  class Orcid::Work
    attr_accessor :title, :author
    def initialize(attributes = {})
      attributes.each {|key, value| send("#{key}=", value) if respond_to?("#{key}=") }
    end
  end

  Mappy.configure do |config|
    config.register(
      source: 'book',
      target: 'orcid/work',
      legend: [
        [:name, :title]
        [lambda{|book| book.authors.first}, :author]
      ]
    )
  end

  book = Book.new(title: 'Hello World', authors: ["George", "Paul", "John", "Ringo"])
  orcid_work = Mappy.map(book, target: 'orcid/work')

  assert_equal orcid_work.title, book.name
  assert_equal orcid_work.author, "George"
```

## Why?

Because I have discovered that I am regularly working with a heterogenious set of
objects that need to be handled via some other service. And that service has its
expected data structure. And there are quite a few services.

That is to say, I'm attempting to submit a work to my Orcid Profile. I need some
method for defining how to map my home grown "Article" object to the attributes
that are needed for a work in my Orcid Profile. And I don't want to infect my Article class
with a #to_orcid_profile method.

Or perhaps I want to create a DOI for my Article. To successfully mint a DOI request, I need to have a valid payload. But what are the odds my Article can be passed directly to the DOI minting service.

In essence, Mappy provides a configurable converter for an application.

## TODO

Perhaps there is a DSL to be found in this.
Maybe I should look to [Lotus::Model::Mapper](https://github.com/lotus/model/blob/master/lib/lotus/model/mapper.rb) and its corresponding Coercer and Collection.