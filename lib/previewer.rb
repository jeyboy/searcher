module Previewer
  require "nokogiri"
  mattr_accessor :max_length

  def self.included(base)
    self.max_length=150
    base.extend(ClassMethods)
  end

  def prepare_preview
    self.body.gsub!(/>\r\n/, ">")
    return if self.body.length < max_length

    doc = Nokogiri::HTML(self.body.gsub(/\r\n/, "<br>"))
    self.preview = html_iterator_wrapper(doc.css('body'))
  end

  module ClassMethods
    def rebuild

    end
  end

private
  def html_iterator_wrapper(block)
    html_iterator(block)
    block.inner_html.gsub(/<br>/, "\r\n")
  end

  def html_iterator(block, counter = 0, lock = false)
    block.children().each do |child|
      if lock
        child.remove
      else
        if child.text?
          counter += (child_content = child.content).length
          if counter > max_length
            len = child_content.index("\n", (child_content.length - (counter - max_length))) || (child_content.length - 1 - (counter - max_length))
            (child.content = child_content[0..(len + 1)] + "...")
          end
        else
          counter, lock = html_iterator(child, counter, lock) unless ['a'].include?(child.node_name)
          lock = counter > max_length
        end
      end
    end
    [counter, lock]
  end
end