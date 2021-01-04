# Ruby Core Extensions

[![Gem Version](https://badge.fury.io/rb/ruby_core_extensions.svg)](http://badge.fury.io/rb/ruby_core_extensions)
[![Build Status](https://github.com/sealink/ruby_core_extensions/workflows/Build%20and%20Test/badge.svg?branch=master)](https://github.com/sealink/ruby_core_extensions/actions)
[![Coverage Status](https://coveralls.io/repos/sealink/ruby_core_extensions/badge.png)](https://coveralls.io/r/sealink/ruby_core_extensions)
[![Code Climate](https://codeclimate.com/github/sealink/ruby_core_extensions.png)](https://codeclimate.com/github/sealink/ruby_core_extensions)

# Description

Extends the core ruby classes with helpful functions

# Installation

Add to your Gemfile:

```ruby
gem 'ruby_core_extensions'
```

# Extensions

The following classes are extend in this gem:

- Array
- BigDecimal
- Class
- Date
- DateTime
- Enumerable
- File
- Fixnum
- Hash
- Kernel
- Numeric
- Object
- Range
- String
- Time

## Release

To publish a new version of this gem the following steps must be taken.

* Update the version in the following files
  ```
    CHANGELOG.md
    lib/ruby_core_extensions/version.rb
  ````
* Create a tag using the format v0.1.0
* Follow build progress in GitHub actions
