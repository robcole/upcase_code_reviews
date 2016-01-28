# Some goold ol' Shakespearean analysis.
#
# Pretending like this might actually be a real user-facing app. Using Net:HTTP
# instead of open-uri due to potential security concerns around handling
# user input. Since we're dealing with user input, we'd eventually  want to add
# more handling around the URL, handling things like infinite redirect, error
# handling, etc. I'd likely use Faraday if I needed to implement more than
# one or two of those things.
#
# For now, just opting for a pretty vanilla setup though. Security discussion
# on open-uri here: http://sakurity.com/blog/2015/02/28/openuri.html
#
# -RC, 1/27/2016
require "nokogiri"
require "net/http"
require "byebug"
ANALYZER_FILES = %w(script_downloader shakespeare_base
                    play scene speech speaker)
ANALYZER_FILES.each { |file| require_relative("./#{file}") }
