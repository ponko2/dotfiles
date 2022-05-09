module.exports = {
  defaultBrowser: "Firefox",
  handlers: [
    {
      match: (options) => {
        if (options.sourceBundleIdentifier !== "com.reederapp.macOS") {
          return false;
        }
        const domains = ["twitter.com", "github.com", "qiita.com"];
        return finicky.matchDomains(domains)(options);
      },
      browser: {
        name: "Google Chrome",
        openInBackground: true,
      },
    },
    {
      match: ({ sourceBundleIdentifier }) =>
        sourceBundleIdentifier === "com.reederapp.macOS",
      browser: {
        name: "Firefox",
        openInBackground: true,
      },
    },
    {
      match: ({ sourceBundleIdentifier }) =>
        [
          // Slack
          "com.tinyspeck.slackmacgap",
          // 1Password
          "com.agilebits.onepassword7",
          // Thunderbird
          "org.mozilla.thunderbird",
          // Excel
          "com.microsoft.Excel",
          // Word
          "com.microsoft.Word",
          // PowerPoint
          "com.microsoft.Powerpoint",
          // Visual Studio Code
          "com.microsoft.VSCode",
          // iTerm2
          "com.googlecode.iterm2",
          // Command Line Tools
          null,
        ].includes(sourceBundleIdentifier),
      browser: "Google Chrome",
    },
  ],
};
