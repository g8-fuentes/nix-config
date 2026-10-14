{
  config,
  lib,
  pkgs,
  theme,
  ...
}:
let
  waylandArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  wallpaper = theme.wallpaper "jupiter";
  vscodeExt = theme.vscode.extension;
  winSystem = "/mnt/c/Windows/System32";
  c = config.lib.stylix.colors.withHashtag;
  terminalScheme = pkgs.writeText "windows-terminal-scheme.json" (
    builtins.toJSON {
      name = "g8-space";
      background = c.base00;
      foreground = c.base05;
      cursorColor = c.base05;
      selectionBackground = c.base02;
      black = c.base00;
      red = c.base08;
      green = c.base0B;
      yellow = c.base0A;
      blue = c.base0D;
      purple = c.base0E;
      cyan = c.base0C;
      white = c.base05;
      brightBlack = c.base03;
      brightRed = c.base08;
      brightGreen = c.base0B;
      brightYellow = c.base0A;
      brightBlue = c.base0D;
      brightPurple = c.base0E;
      brightCyan = c.base0C;
      brightWhite = c.base06;
    }
  );
in
{
  imports = [
    ../astronauts/g8.nix
    ../orbits/cli
    ../orbits/neovim
    ../orbits/dev
  ];

  nixpkgs.config = {
    chromium.commandLineArgs = waylandArgs;
    allowUnfree = true;
  };
  targets.genericLinux.enable = true;

  home.activation.applyWindowsTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    winEnv() { (cd /mnt/c && ${winSystem}/cmd.exe /c "echo %$1%" 2>/dev/null | tr -d '\r'); }
    profile=$(winEnv USERPROFILE) || profile=""
    localAppData=$(winEnv LOCALAPPDATA) || localAppData=""

    if [ -n "$profile" ]; then
      dest="$(/bin/wslpath "$profile")/Pictures/g8-space/wallpaper.png"
      run install -Dm644 ${wallpaper} "$dest"
      winPath=$(/bin/wslpath -w "$dest")
      run ${winSystem}/WindowsPowerShell/v1.0/powershell.exe -NoProfile -NonInteractive -Command "
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WallpaperStyle -Value 10;
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper -Value 0;
        Add-Type -TypeDefinition 'using System.Runtime.InteropServices; public class G8Wallpaper { [DllImport(\"user32.dll\", CharSet = CharSet.Unicode)] public static extern int SystemParametersInfo(int a, int b, string c, int d); }';
        [G8Wallpaper]::SystemParametersInfo(20, 0, '$winPath', 3) | Out-Null
      "
    else
      warnEcho "Windows interop unavailable; Windows wallpaper not applied"
    fi

    if [ -n "$localAppData" ]; then
      appData=$(/bin/wslpath "$localAppData")
      for settings in \
        "$appData/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" \
        "$appData/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json" \
        "$appData/Microsoft/Windows Terminal/settings.json"; do
        [ -f "$settings" ] || continue
        [ -f "$settings.g8-backup" ] || run cp "$settings" "$settings.g8-backup"
        if updated=$(${pkgs.jq}/bin/jq --slurpfile scheme ${terminalScheme} '
          .schemes = (((.schemes // []) | map(select(.name != "g8-space"))) + $scheme)
          | .profiles.defaults.colorScheme = "g8-space"
        ' "$settings"); then
          if [ -z "''${DRY_RUN:-}" ]; then
            printf '%s\n' "$updated" > "$settings"
          fi
          verboseEcho "Windows Terminal theme applied to $settings"
        else
          warnEcho "Could not parse $settings (comments in JSON?); Windows Terminal theme not applied"
        fi
      done
    fi

    appDataRoaming=$(winEnv APPDATA) || appDataRoaming=""
    codeCmd="$localAppData\\Programs\\Microsoft VS Code\\bin\\code.cmd"
    if [ -n "$localAppData" ] && [ -n "$appDataRoaming" ] && [ -f "$(/bin/wslpath "$codeCmd")" ]; then
      powershell=${winSystem}/WindowsPowerShell/v1.0/powershell.exe
      installed=$($powershell -NoProfile -NonInteractive -Command "& '$codeCmd' --list-extensions --show-versions" 2>/dev/null | tr -d '\r')
      if ! printf '%s\n' "$installed" | grep -qxiF '${vscodeExt.vscodeExtUniqueId}@${vscodeExt.version}'; then
        vsix="$(/bin/wslpath "$localAppData")/g8-space/${vscodeExt.vscodeExtUniqueId}-${vscodeExt.version}.vsix"
        run install -Dm644 ${vscodeExt.src} "$vsix"
        run $powershell -NoProfile -NonInteractive -Command "& '$codeCmd' --install-extension '$(/bin/wslpath -w "$vsix")' --force"
      fi

      codeSettings="$(/bin/wslpath "$appDataRoaming")/Code/User/settings.json"
      if [ -f "$codeSettings" ]; then
        [ -f "$codeSettings.g8-backup" ] || run cp "$codeSettings" "$codeSettings.g8-backup"
        if updated=$(${pkgs.jq}/bin/jq --arg theme ${lib.escapeShellArg theme.vscode.colorTheme} '."workbench.colorTheme" = $theme' "$codeSettings"); then
          if [ -z "''${DRY_RUN:-}" ]; then
            printf '%s\n' "$updated" > "$codeSettings"
          fi
          verboseEcho "VSCode theme applied to $codeSettings"
        else
          warnEcho "Could not parse $codeSettings (comments in JSON?); VSCode theme not applied"
        fi
      fi
    else
      warnEcho "VSCode for Windows not found; VSCode theme not applied"
    fi
  '';
}
