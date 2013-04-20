require 'mkmf'

unless have_library('disasm')
  abort "libdisasm is missing, please install from http://bastard.sourceforge.net/libdisasm.html"
end

unless have_header('libdis.h')
  abort "libdis.h is missing, please install libdisasm from http://bastard.sourceforge.net/libdisasm.html"
end

create_makefile 'disasm_ext'
