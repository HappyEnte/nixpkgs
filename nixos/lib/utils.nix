pkgs: with pkgs.lib;

rec {

  # Escape a path according to the systemd rules, e.g. /dev/xyzzy
  # becomes dev-xyzzy.  FIXME: slow.
  escapeSystemdPath = s:
   replaceChars ["/" "-" " "] ["-" "\\x2d" "\\x20"]
    (if hasPrefix "/" s then substring 1 (stringLength s) s else s);

  # Returns a system path for a given shell package
  toShellPath = shell:
    if types.shellPackage.check shell then
      "/run/current-system/sw${shell.shellPath}"
    else
      shell;
}
