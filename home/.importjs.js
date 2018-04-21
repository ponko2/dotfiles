module.exports = {
  aliases: {
    $: "node_modules/jquery",
    _: "node_modules/lodash",
    fp: "node_modules/lodash/fp",
    ko: "node_modules/knockout",
    logdown: "node_modules/logdown",
    moment: "node_modules/moment",
    BigNumber: "node_modules/bignumber.js",
    "query-string": "node_modules/query-string"
  },
  namedExports: {
    "node_modules/@profiscience/knockout-contrib-router": [
      'Route',
      'Router'
    ]
  },
  groupImports: false,
  sortImports: false,
  emptyLineBetweenGroups: false,
  danglingCommas: false,
  useRelativePaths: false,
  maxLineLength: 120,
  importStatementFormatter({ importStatement }) {
    return importStatement
      .replace("src/main/webapp/WEB-INF/js/", "")
      .replace(/'([^']+)'/, '"$1"');
  }
}
