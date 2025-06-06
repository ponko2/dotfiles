/**
 * @filename: lint-staged.config.js
 * @type {import('lint-staged').Configuration}
 */
export default {
  "*.lua": ["luacheck", "stylua"],
  "*.{cjs,cts,js,json,jsonc,jsx,mjs,mts,ts,tsx}": "biome check --write",
  "*.{yaml,yml}": "yamllint",
};
