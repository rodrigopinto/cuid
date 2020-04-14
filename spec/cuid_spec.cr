require "./spec_helper"

def cuid_expcted_format
  number_of_characters = 24

  /c[a-z0-9]{#{number_of_characters}}/
end

describe CUID do
  describe "random" do
    it "does inspect" do
      subject = CUID.random
      subject.inspect.should eq "CUID(#{subject})"
    end

    it "returns a string with the correct format" do
      subject = CUID.random

      subject.to_s.size.should eq(25)
      subject.to_s.should match(cuid_expcted_format)
    end

    it "is colission resistant" do
      results = Hash(String, String).new
      any_colission = false
      i = 0
      limit = 1000000

      while i < limit
        cuid = CUID.random.to_s

        if results[cuid]?
          any_colission = true
          break
        else
          results[cuid] = cuid
        end

        i += 1
      end

      any_colission.should be_false
    end
  end
end
