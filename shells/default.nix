{pkgs, ...}:
with pkgs; {
  funcprog = mkShell {
    nativeBuildInputs = [python310];
  };

  compsys = mkShell {
    nativeBuildInputs = [gnumake bear clang];
  };
}
