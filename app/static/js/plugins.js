(function() {
  var console, length, method, methods, noop;

  method = void 0;

  noop = function() {};

  methods = ["assert", "clear", "count", "debug", "dir", "dirxml", "error", "exception", "group", "groupCollapsed", "groupEnd", "info", "log", "markTimeline", "profile", "profileEnd", "table", "time", "timeEnd", "timeStamp", "trace", "warn"];

  length = methods.length;

  console = (window.console = window.console || {});

  while (length--) {
    method = methods[length];
    if (!console[method]) {
      console[method] = noop;
    }
  }

}).call(this);
