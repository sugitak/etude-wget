require 'test/unit'
cwd = File.dirname(__FILE__)
require "./#{cwd}/../lib/parser"

class TestCase_Parser < Test::Unit::TestCase
  def setup
    @html = %q{<html><head><title>Title</title></head><body><p><h1><img src="some/path">Header</h1></p>
    <p><a href="somewhere">bbb</a><a href="some/other/path">bbb</a><a id="anker">abc</a></p></body></html>}
  end

  def parser
    # create new parser, in case replace does some weird things
    Parser.new(@html)
  end

  def test_count_links
    assert_equal 2, parser.count_links
  end

  def test_count_images
    assert_equal 1, parser.count_images
  end

  def test_canonical_path
    assert_equal "some.host_some_path.img",
      Parser.canonical_path("https://some.host/some/path.img")
    assert_equal "some.host_some_path.img",
      Parser.canonical_path("some.host/some/path.img")
    assert_equal "some.host_some_path.img",
      Parser.canonical_path("./some.host/some/path.img")
  end
end
