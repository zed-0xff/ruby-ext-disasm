module Disasm
  class << self
    def disasm data, params = {}
      rva    = params[:rva] || 0
      offset = params[:offset] || 0

      if block_given?
        disassemble2yield(data, rva, offset) do |x|
          yield x
        end
      else
        r = []
        disassemble2yield(data, rva, offset) do |x|
          r << x
        end
        r
      end
    end

    alias :disassemble :disasm
  end
end
