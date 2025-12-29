return {
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import <nixpkgs> { }',
      },
      formatting = {
        command = { 'nixfmt' },
      },
      options = {
        nix_darwin = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).darwinConfigurations.ponko2.options',
        },
      },
    },
  },
}
