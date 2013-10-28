# Description:
#  Fetch a quote from La classe américaine
#
# Dependencies:
#   "jsdom" : ""
#
# Commands:
#   None
jsdom = require 'jsdom'

module.exports = (robot) ->
  # match URL like http://cyclim.se/script.html#0:05:26
  robot.hear /http:\/\/cyclim.se\/script.html\#([0-9:]+)/i, (msg) ->
    url = 'http://cyclim.se/script.html'
    jsdom.env url, [ 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js' ], (errors, window) ->
        (($) ->
          name = $("a[name='#{msg.match[1]}']")
          content = name.parent().text()

          msg.send content
        )(window.jQuery)
