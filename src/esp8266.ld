ENTRY(_start)

MEMORY
{
    iram_seg : org = 0x40100000, len = 0x8000
}

SECTIONS
{
    .text :
    {
        . = ALIGN(4);
        *(.literal)
        *(.literal.*)
        *(.text)
        *(.text.*)
    } > iram_seg
}