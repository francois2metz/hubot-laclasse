# Description:
#  Fetch a quote from La classe américaine
#
# Dependencies:
#   None
#
# Commands:
#   None
jsdom = require 'jsdom'

module.exports = (robot) ->
  # match URL like http://cyclim.se/script.html#0:05:26
  robot.hear /http:\/\/cyclim.se\/(script|derrick-script|cadetourne-script).html\#([0-9:]+)/i, (msg) ->
    url = "http://cyclim.se/#{msg.match[1]}.html"
    findQuote url, msg.match[2], (content) ->
      msg.send content

findQuote = (url, time, callback) ->
  jsdom.env url, ['http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'], (errors, window) ->
    (($) ->
      name = $("a[name='#{time}']")
      content = name.parent().text()
      callback content
    )(window.jQuery)
