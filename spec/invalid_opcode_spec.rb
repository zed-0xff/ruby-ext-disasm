require 'spec_helper'

describe Disasm do
  describe "invalid opcode" do
    it "raises Disasm::InvalidOpcode with VA & offset" do
      data = "\xff\xff\xff\xff"

      ex = nil
      begin
        Disasm.disasm(data, :va => 0x2000)
      rescue Disasm::Exception
        ex = $!
      end

      ex.should be_instance_of(Disasm::InvalidOpcode)
      ex.va.should == 0x2000
      ex.offset.should == 0
    end

    it "yields 'invalid' if :allow_invalid = true" do
      data = "\xff\xff"

      a = Disasm.disasm(data, :va => 0x2000, :allow_invalid => true, :syntax => :native)
      a.size.should == 2
      a[0].strip.should == "00002000\tFF \tinvalid"
      a[1].strip.should == "00002001\tFF \tinvalid"
    end
  end
end
