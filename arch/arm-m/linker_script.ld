/**
 * executable.ld
 *
 * Copyright (C) 2023 Mateusz Stadnik <matgla@live.com>
 *
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version
 * 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 * PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General
 * Public License along with this program. If not, see
 * <https://www.gnu.org/licenses/>.
 */

MEMORY
{
  image(rwx) : ORIGIN = 0x00000000, LENGTH = 0xffffffff
}

PHDRS
{
  code         PT_LOAD;
  data         PT_LOAD;
}


SECTIONS
{
  .text :
  {
    . = ALIGN(16);
    KEEP(*(.entry))
    *(.text)
    *(.text*)
    *(.glue_7)
    *(.glue_7t)
    *(.eh_frame)
    KEEP(*(.init))
    KEEP(*(.fini))
    *(.rodata)
    *(.rodata*)
    . = ALIGN(16);
  } > image :code

  .init_arrays :
  {
    . = ALIGN(16); 
    PROVIDE_HIDDEN(__preinit_array_start = .);
    KEEP(*SORT(.preinit_array.*))
    KEEP(*(.preinit_array))
    PROVIDE_HIDDEN(__preinit_array_end = .);
    . = ALIGN(16); 
    PROVIDE_HIDDEN(__init_array_start = .);
    KEEP(*SORT(.init_array.*))
    KEEP(*(.init_array))
    PROVIDE_HIDDEN(__init_array_end = .);
    . = ALIGN(16);
    PROVIDE_HIDDEN(__fini_array_start = .);
    KEEP(*SORT(.fini_array.*))
    KEEP(*SORT(.fini_array))
    PROVIDE_HIDDEN(__fini_array_end = .);
    . = ALIGN(16);
  } > image :code

  .data :
  {
    . = ALIGN(16);
    *(.data)
    *(.data*)
    . = ALIGN(16);
  } > image :data

  .bss :
  {
    . = ALIGN(4);
    *(.bss)
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
  } > image :data

  .plt :
  {
    *(.plt*)
  } > image :code

  .got :
  {
    *(.got)
  } > image :data

  .got.plt :
  {
    *(.got.plt)
  } > image :data

  .dynsym :
  {
    *(.dynsym*)
  } > image 

  .dynstr :
  {
    *(.dynstr*)
  } > image


  .ARM.extab :
  {
    *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > image 

  .ARM.exidx :
  {
    *(.ARM.exidx* .gnu.linkonce.armextab.*)
  } > image 

  .plt.rel : 
  {
    *(.plt.rel*)
  } > image


  .interp : 
  {
    *(.interp)
  } > image

  .hash :
  {
    *(.hash)
  } > image

  .dynamic : 
  {
    *(.dynamic)
  } > image
}
