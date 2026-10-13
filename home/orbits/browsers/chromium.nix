{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    commandLineArgs = [ "--no-default-browser-check" ];
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
      { id = "gphhapmejobijbbhgpjhcjognlahblep"; }
      { id = "fmkadmapgofadopljbjfkapdkoienihi"; }
      { id = "lmhkpmbekcpmknklioeibfkpmmfibljd"; }
      { id = "jdkknkkbebbapilgoeccciglkfbmbnfm"; }
      { id = "bcjindcccaagfpapjjmafapmmgkkhgoa"; }
      { id = "aapbdbdomjkkjkaonfhkkikfgjllcleb"; }
      { id = "fnaicdffflnofjppbagibeoednhnbjhg"; }
      { id = "bkdgflcldnnnapblkhphbgpggdiikppg"; }
      { id = "gighmmpiobklfepjocnamgkkbiglidom"; }
      { id = "djnghjlejbfgnbnmjfgbdaeafbiklpha"; }
    ];
  };
}
