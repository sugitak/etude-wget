require 'open-uri'
require 'time'

cwd = File.dirname(__FILE__)
require "#{cwd}/parser"

class Fetcher
  def initialize(url)
    @url = url.to_s
    @uri = URI.parse(@url)
    @filename = "#{@uri.host}.html"
  end

  def fetch
    fetch_and_save
  end

  def print_metadata
    begin
      $stdout.puts Metadata.new(@uri, nil).read
    rescue Errno::ENOENT
      $stderr.puts "No metadata for:  #{@url}\n"
    end
  end

  # actual fetch
  # returns; string
  def _fetch
    io = OpenURI.open_uri(@url)
    return io
  end

  def fetch_and_save
    File.open(@filename, mode="w") do |f|
      body = _fetch.read
      Metadata.new(@uri, body).save!
      f.write(body)
    end
  end

  def self.fetch_all(urls)
    urls.each do |url|
      begin
        Fetcher.new(url).fetch
      rescue => e
        $stderr.puts "ERROR: #{url}: #{e}"
      end
    end
  end

  def self.fetch_all_metadata(urls)
    urls.each do |url|
      Fetcher.new(url).print_metadata
    end
  end

  class Metadata
    def initialize(uri, body)
      @uri = uri
      if body
        @parser = Parser.new(body)
        set_meta
      end
    end

    def filename
      @filename ||= "run/.meta__#{@uri.host}.html"
    end

    def set_meta
      @site ||= @uri.host
      @num_links ||= @parser.count_links
      @images ||= @parser.count_images
      @last_fetch ||= Time.now
    end

    # This time, simply output to file :<
    # It would be better if I use SQLite3 so that I can save all the history
    def save!
      File.open(filename, mode="w") do |f|
        f.write("site: #{@site}\n" +
                "num_links:#{@num_links}\n" +
                "images: #{@images}\n" +
                "last_fetch: #{@last_fetch}\n")
      end
    end

    def read
      File.open(filename, mode="r").read
    end
  end
end
