method = undefined
noop = ->

methods = [ "assert", "clear", "count", "debug", "dir", "dirxml", "error", "exception", "group", "groupCollapsed", "groupEnd", "info", "log", "markTimeline", "profile", "profileEnd", "table", "time", "timeEnd", "timeStamp", "trace", "warn" ]
length = methods.length
console = (window.console = window.console or {})
while length--
    method = methods[length]
    console[method] = noop  unless console[method]