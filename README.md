Haikuify [![Build Status](https://travis-ci.org/data-twister/haikuify.svg?branch=master)](https://travis-ci.org/data-twister/haikuify) 
==========

Generate Heroku-like memorable random names to use in your apps or anywhere else.

Installation
------------

Add Haikuify to your `mix.exs` dependencies:

```elixir
defp deps do
  [{:haikuify, "~> 0.0.0"}]
end
```

Then run `$ mix deps.get`. And also `$ mix deps.compile`, for kicks.

Usage
-----

```elixir
Haikuify.build # => "morning-star-6817"

# Token range
Haikuify.build(100) # => "summer-dawn-24"

# Don't include the token
Haikuify.build(0) # => "ancient-frost"

# Use a different delimiter
Haikuify.build(9999, ".") # => "frosty.leaf.8347"

# No token, no delimiter
Haikuify.build(0, "") # => "twilightbreeze"

# Text token, no delimiter
Haikuify.build("suffix", "") # => "twilightbreezesuffix"

# Text token, different delimiter
Haikuify.build("suffix", ".") # => "frosty.leaf.suffix"
```

License
-------

Copyright (c) 2015 Kash Nouroozi
Maintained (c) 2026 Jason Clark

This work is free. You can redistribute it and/or modify it under the terms of the MIT License. See the LICENSE file for more details.
