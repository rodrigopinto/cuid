# cuid (Deprecated)

Implementation of https://github.com/ericelliott/cuid in Crystal.

The `CUID` is a Crystal library that provides collision-resistant IDs optimized for horizontal scaling and sequential lookup performance.

## Status: Deprecated due to security. 
### See original implementation [Cuid2](https://github.com/paralleldrive/cuid2), not yet ported to Crystal.

> Note: All monotonically increasing (auto-increment, k-sortable), and timestamp-based ids share the security issues with Cuid. V4 UUIDs and GUIDs are also insecure because it's possible to predict future values of many random algorithms, and many of them are biased, leading to increased probability of collision. Likewise, UUID V6-V8 are also insecure because they leak information which could be used to exploit systems or violate user privacy. Here are some example exploits:
>
> * [Unauthorized password reset via guessable ID](https://infosecwriteups.com/bugbounty-how-i-was-able-to-compromise-any-user-account-via-reset-password-functionality-a11bb5f863b3)
> * [Unauthorized access to private GitLab issues via guessable ids](https://infosecwriteups.com/how-this-easy-vulnerability-resulted-in-a-20-000-bug-bounty-from-gitlab-d9dc9312c10a)
> * [Unauthorized password reset via guid](https://www.intruder.io/research/in-guid-we-trust)



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
