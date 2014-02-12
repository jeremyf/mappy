# Mappy [![Build Status](https://travis-ci.org/jeremyf/mappy.png?branch=master)](https://travis-ci.org/jeremyf/mappy)

Map one object to another. Apsiring to be a DSL for mapping one object's "data
structure" onto another object's "data structure".

## Why?

Because I have discovered that I am regularly working with a heterogenious set of
objects that need to be handled via some other service. And that service has its
expected data structure. And there are quite a few services.

That is to say, I'm attempting to submit a work to my Orcid Profile. I need some
method for defining how to map my home grown "Article" object to the attributes
that are needed for an Orcide work. And I don't want to infect my Article class
with a #to_orcid_profile_attributes method.

Or I want to create a DOI for my Article.

In essence, Mappy provides a configurable seam in an application.

## Installation

Add this line to your application's Gemfile:

    gem 'mappy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mappy
