# cuid

Implementation of https://github.com/ericelliott/cuid in Crystal.

The `CUID` is a Crystal library that provides collision-resistant ids optimized for horizontal scaling and sequential lookup performance.

This is just going to cover the Crystal implementation details.

**Please refer to the [main project site](http://usecuid.org) for the full story.**

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     cuid:
       github: rodrigopinto/cuid
   ```

2. Run `shards install`

## Usage

#### Basic

```crystal
require "cuid"

cuid = CUID.random

cuid.to_s # => ck8vrqmp20000df63z8lsaahr
```

#### JSON Mapping

```crystal
require "cuid"
require "cuid/json"

class Example
  JSON.mapping id: CUID
end

example = Example.from_json(%({"id": "ck8vrqmp20000df63z8lsaahr"}))

cuid = CUID.random
cuid.to_json # => "\"ck8vrqmp20000df63z8lsaahr\""
```

### Explanation

`c - k8vrqmp2 - 0000 - df63 - z8lsaahr`

The groups, in order, are:

* 'c' - identifies this as a cuid, and allows you to use it in html entity ids.

* Timestamp in milliseconds since the epoch coverted in base 36.

* Counter - A single process might generate the same random string. The weaker the pseudo-random source, the higher the probability. That problem gets worse as processors get faster. The counter will roll over if the value gets too big.

* Fingerprint - The first two characters are based on the process id(`Process.pid`) and the next two characters are based on the hostname(`System.hostname`). Same method used in the original Node implementation.

* Random - It uses a cryptographically secure pseudorandom number `Random::Secure#rand` function.

## Development

Contributions are welcome. Make sure to check the existing issues (including the closed ones) before requesting a feature, reporting a bug or opening a pull requests.

### Getting started

Install dependencies:

```sh
shards install
```

Run tests:

```sh
crystal spec
```

Format the code:

```sh
crystal tool format
```

### Contributing

1. Fork it (<https://github.com/rodrigopinto/cuid/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Maintainer

- [Rodrigo Pinto](https://github.com/rodrigopinto) - creator and maintainer
