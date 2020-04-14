require "json"
require "../cuid"

# Adds JSON support to `CUID`.
#
# NOTE: `require "cuid/json"` is required to use this feature.
#
# ```
# require "cuid"
# require "cuid/json"
#
# class Example
#   JSON.mapping id: CUID
# end
#
# example = Example.from_json(%({"id": "ck8vrqmp20000df63z8lsaahr"}))
#
# cuid = CUID.random
# cuid.to_json # => "\"ck8vrqmp20000df63z8lsaahr\""
# ```
struct CUID
  def self.new(pull : JSON::PullParser)
    new(pull.read_string)
  end

  def to_json(json : JSON::Builder)
    json.string(to_s)
  end
end
