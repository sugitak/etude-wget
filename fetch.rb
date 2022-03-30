#!/usr/bin/env ruby

require 'open-uri'

class Fetcher
  def initialize(url)
    @url = url.to_s
    @uri = URI.parse(@url)
    @filename = "#{@uri.host}.html"
  end

  def fetch
    fetch_and_save
  end

  # actual fetch
  # returns; string
  def _fetch
    io = OpenURI.open_uri(@url)
    return io.read
  end

  def fetch_and_save
    File.open(@filename, mode="w") do |f|
      f.write(_fetch)
    end
  end
end
