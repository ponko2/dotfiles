finicky.setDefaultBrowser('com.google.Chrome');

finicky.onUrl(function (url, opts) {
  var sourceApplication = opts && opts.sourceBundleIdentifier;

  var chrome = {
    bundleIdentifier: 'com.google.Chrome'
  };

  var firefox = {
    bundleIdentifier: 'org.mozilla.firefox',
    openInBackground: true
  };

  // SNS
  if (url.match(/^https?:\/\/twitter\.com/)) {
    return chrome;
  }

  // Tech
  if (url.match(/^https?:\/\/(github|qiita)\.com/)) {
    return chrome;
  }

  // Reeder
  if (sourceApplication === 'com.reederapp.rkit2.mac') {
    return firefox;
  }

  // Slack
  if (sourceApplication === 'com.tinyspeck.slackmacgap') {
    return firefox;
  }
});
