finicky.setDefaultBrowser('com.google.Chrome');

finicky.onUrl(function (url, opts) {
  var sourceApplication = opts && opts.sourceBundleIdentifier;

  var firefox = {
    bundleIdentifier: 'org.mozilla.firefox',
    openInBackground: true
  };

  // Reeder
  if (sourceApplication === 'com.reederapp.rkit2.mac') {
    return firefox;
  }

  // Slack
  if (sourceApplication === 'com.tinyspeck.slackmacgap') {
    return firefox;
  }
});
