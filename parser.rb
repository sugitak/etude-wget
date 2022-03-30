require 'nokogiri'

class Parser
  def initialize(data)
    @parser = Nokogiri::HTML.parse(data)
  end

  def links
    @links ||= @parser.xpath('//a/@href')
  end

  def images
    @images ||= @parser.xpath('//img')
  end

  def count_links
    links.count
  end

  #   TODO: how could we count CSS-placed images :thinking:
  def count_images
    images.count
  end

  def replace_images_to_local_path
    images.each do |image|
    end
  end
end
