/**
 * @filename: lint-staged.config.js
 * @type {import('lint-staged').Configuration}
 */
export default {
  "*.lua": ["luacheck", "stylua"],
  "*.{js,jsx,ts,tsx,cjs,cts,mjs,mts,json,jsonc,css,svelte,vue,astro,graphql,gql}":
    "biome check --write --files-ignore-unknown=true --no-errors-on-unmatched",
  "*.{yaml,yml}": "yamllint",
};
