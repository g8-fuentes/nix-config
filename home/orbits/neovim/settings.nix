{ options, outputs, ... }:
{
  programs.nixvim = outputs.lib.existing (options.programs.nixvim.type.getSubOptions [ ]) {
    globals = {
      mapleader = ";";
    };
    clipboard = {
      register = "unnamedplus";
    };
  };
}
