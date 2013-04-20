require 'disasm_ext'

module Disasm

  class Exception < ::Exception; end
  class InvalidOpcode < Exception
    attr_accessor :offset, :va

    def initialize offset, va
      @offset = offset
      @va = va
    end

    def to_s
      "Invalid instruction at offset 0x%x (VA 0x%x)" % [@offset, @va]
    end
  end

  class << self
    def disasm data, params = {}
      rva    = params[:rva] || params[:va] || 0
      offset = params[:offset] || 0

      syntax =
        case params[:syntax]
        when :native; 1
        when :intel;  2
        when :att;    3
        when :xml;    4
        when :raw;    5
        else 1          # default to native syntax
        end

      allow_invalid = params[:allow_invalid] ? true : false

      if block_given?
        disassemble2yield(data, rva, offset, syntax, allow_invalid) do |x,va|
          yield x,va
        end
      else
        r = []
        disassemble2yield(data, rva, offset, syntax, allow_invalid) do |x|
          r << x
        end
        r
      end
    end

    alias :disassemble :disasm
  end
end
