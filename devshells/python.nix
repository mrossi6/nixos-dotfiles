{ mkShell, pkgs, ... }:
mkShell {
  name = "python";
  packages = with pkgs; [
    python3
    python3Packages.ipython
    ruff
    uv
    ty
  ];
  env = {
    UV_PYTHON_DOWNLOADS = "never";
    UV_PYTHON_PREFERENCE = "only-system";
  };
}
