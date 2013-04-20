require 'spec_helper'

describe Disasm do
  describe "high VA" do
    it "converted correctly to unsigned int" do
      data = "\x55\x40"

      idx = 0
      Disasm.disasm(data, :va => 0x71050000, :syntax => :native) do |line, va|
        line.strip!.tr!("\t"," ")
        case idx
        when 0
          va.should   == 0x71050000
          line.should == "71050000 55  push ebp"
        when 1
          va.should   == 0x71050001
          line.should == "71050001 40  inc eax"
        else
          raise "only two iterations there must be"
        end
        idx += 1
      end
    end

    if RUBY_PLATFORM['_64']
      it "should be tested on x86 32-bit, may behave different from x86_64"
    end
  end
end
