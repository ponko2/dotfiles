export default {
  extends: ["@commitlint/config-conventional"],
  rules: {
    // ProTip: Great commit summaries are 50 characters or less. Place extra information in the extended description.
    "header-max-length": [2, "always", 50],
  },
  ignores: [
    (commit) => /^Signed-off-by: dependabot\[bot] <support@github\.com>$/m.test(commit),
    (commit) =>
      /^Signed-off-by: renovate\[bot] <29139614\+renovate\[bot]@users\.noreply\.github\.com>$/m.test(
        commit,
      ),
  ],
};
