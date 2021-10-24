require "./spec_helper"
require "../src/cuid/json"

private class JSONWithCUID
  include JSON::Serializable

  property value : CUID
end

describe CUID do
  it "parses CUID from JSON" do
    obj = JSONWithCUID.from_json(%({"value": "ck8vrqmp20000df63z8lsaahr"}))
    obj.should be_a(JSONWithCUID)
    obj.value.should eq(CUID.new("ck8vrqmp20000df63z8lsaahr"))
  end
end
