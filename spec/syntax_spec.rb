require 'spec_helper'

describe Disasm do
  describe "[native syntax]" do
    it "yields disasm" do
      data = "\x83\xf8\x01"
      Disasm.disasm(data, :va => 0x516000, :syntax => :native ) do |line,va|
        line.strip.should == "00516000\t83 F8 01 \tcmp\teax\t0x01"
        va.should == 0x516000
      end
    end

    it "disasms to array" do
      data = "\x83\xf8\x01"
      a = Disasm.disasm(data, :va => 0x516000, :syntax => :native )
      a.size.should == 1
      a.first.strip.should == "00516000\t83 F8 01 \tcmp\teax\t0x01"
    end
  end

  describe "[intel syntax]" do
    it "yields disasm" do
      data = "\x83\xf8\x01"
      Disasm.disasm(data, :va => 0x516000, :syntax => :intel ) do |line,va|
        line.strip.should == "cmp\teax, 0x01"
        va.should == 0x516000
      end
    end

    it "disasms to array" do
      data = "\x83\xf8\x01"
      a = Disasm.disasm(data, :va => 0x516000, :syntax => :intel )
      a.size.should == 1
      a.first.strip.should == "cmp\teax, 0x01"
    end
  end

  describe "[at&t syntax]" do
    it "yields disasm" do
      data = "\x83\xf8\x01"
      Disasm.disasm(data, :va => 0x516000, :syntax => :att ) do |line,va|
        line.strip.should == "cmp\t$0x01, %eax"
        va.should == 0x516000
      end
    end

    it "disasms to array" do
      data = "\x83\xf8\x01"
      a = Disasm.disasm(data, :va => 0x516000, :syntax => :att )
      a.size.should == 1
      a.first.strip.should == "cmp\t$0x01, %eax"
    end
  end
end
