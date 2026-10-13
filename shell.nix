{ pkgs }:
{
  default = pkgs.mkShell {
    packages = with pkgs; [
      git
      nixfmt
      sops
      age
      ssh-to-age
    ];
  };
}
