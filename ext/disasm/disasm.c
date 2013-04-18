#include "ruby.h"
#include <libdis.h>

#define LINE_SIZE 1024

static VALUE t_init(VALUE self)
{
    return INT2FIX(x86_init(opt_none, NULL, NULL));
}

static VALUE t_disassemble2yield(VALUE self, VALUE _data, VALUE _rva, VALUE _offset)
{
    x86_insn_t insn;
    int size, line_len;
    char line[LINE_SIZE];

    char*buf             = RSTRING_PTR(_data);
    unsigned int bufsize = RSTRING_LEN(_data);
    uint32_t rva         = FIX2INT(_rva);
    unsigned int offset  = FIX2INT(_offset);

    while( offset < bufsize ){
        size = x86_disasm(buf, bufsize, rva, offset, &insn);
        if( size ){
            // success
            line_len = x86_format_insn(&insn, line, LINE_SIZE, intel_syntax);
            rb_yield(rb_str_new(line, line_len));
            offset += size;
        } else {
            // invalid instruction
            rb_yield(INT2FIX(-1));
            break;
        }
    }

    return INT2FIX(bufsize);
}

VALUE mDisasm;

void Init_disasm() {
    x86_init(opt_none, NULL, NULL);
    mDisasm = rb_define_module("Disasm");
    rb_define_singleton_method(mDisasm, "init", t_init, 0);
    rb_define_singleton_method(mDisasm, "disassemble2yield", t_disassemble2yield, 3);
}
