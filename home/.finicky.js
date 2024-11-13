module.exports = {
  defaultBrowser: "Firefox",
  handlers: [
    {
      match: (options) => {
        if (options.opener.bundleId !== "com.reederapp.macOS") {
          return false;
        }
        const domains = [
          "github.com",
          "qiita.com",
          "twitter.com",
          "youtube.com",
        ];
        return finicky.matchDomains(domains)(options);
      },
      browser: {
        name: "Google Chrome",
        openInBackground: true,
      },
    },
    {
      match: ({ opener }) => opener.bundleId === "com.reederapp.macOS",
      browser: {
        name: "Firefox",
        openInBackground: true,
      },
    },
    {
      match: ({ opener }) =>
        [
          // Slack
          "com.tinyspeck.slackmacgap",
          // 1Password
          "com.1password.1password",
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
        ].includes(opener.bundleId),
      browser: "Google Chrome",
    },
  ],
};
