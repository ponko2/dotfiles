// Configs
S.configAll({
  "defaultToCurrentScreen"  : true,
  "nudgePercentOf"          : "screenSize",
  "resizePercentOf"         : "screenSize",
  "secondsBetweenRepeat"    : 0.1,
  "checkDefaultsOnLoad"     : true,
  "focusCheckWidthMax"      : 3000,
  "orderScreensLeftToRight" : false
});

S.bindAll({
  // Resize Bindings
  "l:alt"      : S.op("resize", { "width" : "+10%", "height" : "+0" }),
  "h:alt"      : S.op("resize", { "width" : "-10%", "height" : "+0" }),
  "k:alt"      : S.op("resize", { "width" : "+0",   "height" : "-10%" }),
  "j:alt"      : S.op("resize", { "width" : "+0",   "height" : "+10%" }),
  "l:ctrl;alt" : S.op("resize", { "width" : "-10%", "height" : "+0",   "anchor" : "bottom-right" }),
  "h:ctrl;alt" : S.op("resize", { "width" : "+10%", "height" : "+0",   "anchor" : "bottom-right" }),
  "k:ctrl;alt" : S.op("resize", { "width" : "+0",   "height" : "+10%", "anchor" : "bottom-right" }),
  "j:ctrl;alt" : S.op("resize", { "width" : "+0",   "height" : "-10%", "anchor" : "bottom-right" }),

  // Push Bindings
  "l:ctrl;cmd" : S.op("push", { "direction" : "right", "style" : "bar-resize:screenSizeX/2" }),
  "h:ctrl;cmd" : S.op("push", { "direction" : "left",  "style" : "bar-resize:screenSizeX/2" }),
  "k:ctrl;cmd" : S.op("push", { "direction" : "up",    "style" : "bar-resize:screenSizeY/2" }),
  "j:ctrl;cmd" : S.op("push", { "direction" : "down",  "style" : "bar-resize:screenSizeY/2" }),

  // Nudge Bindings
  "l:shift;alt" : S.op("nudge", { "x" : "+10%", "y" : "+0" }),
  "h:shift;alt" : S.op("nudge", { "x" : "-10%", "y" : "+0" }),
  "k:shift;alt" : S.op("nudge", { "x" : "+0",   "y" : "-10%" }),
  "j:shift;alt" : S.op("nudge", { "x" : "+0",   "y" : "+10%" }),

  // Throw Bindings
  "1:ctrl;alt"     : S.op("throw", { "screen" : "0",     "width" : "screenSizeX", "height" : "screenSizeY" }),
  "2:ctrl;alt"     : S.op("throw", { "screen" : "1",     "width" : "screenSizeX", "height" : "screenSizeY" }),
  "3:ctrl;alt"     : S.op("throw", { "screen" : "2",     "width" : "screenSizeX", "height" : "screenSizeY" }),
  "l:ctrl;alt;cmd" : S.op("throw", { "screen" : "right", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "h:ctrl;alt;cmd" : S.op("throw", { "screen" : "left",  "width" : "screenSizeX", "height" : "screenSizeY" }),
  "k:ctrl;alt;cmd" : S.op("throw", { "screen" : "up",    "width" : "screenSizeX", "height" : "screenSizeY" }),
  "j:ctrl;alt;cmd" : S.op("throw", { "screen" : "down",  "width" : "screenSizeX", "height" : "screenSizeY" }),

  // Focus Bindings
  "l:cmd"     : S.op("focus", { "direction" : "right" }),
  "h:cmd"     : S.op("focus", { "direction" : "left" }),
  "k:cmd"     : S.op("focus", { "direction" : "up" }),
  "j:cmd"     : S.op("focus", { "direction" : "down" }),
  "k:cmd;alt" : S.op("focus", { "direction" : "behind" }),
  "j:cmd;alt" : S.op("focus", { "direction" : "behind" }),

  // Window Hints
  "esc:cmd" : S.op("hint"),

  // Grid
  "esc:ctrl" : S.op("grid")
});
