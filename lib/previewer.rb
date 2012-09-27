module Previewer
  require "nokogiri"
  mattr_accessor :max_length

  def self.included(base)
    self.max_length=150
    base.extend(ClassMethods)
  end

  def prepare_preview
    doc = Nokogiri::HTML(self.body)
    counter = max_length
    #doc.css('*') do |elem|
    #counter -= elem.html
    #end
    self.preview_count = counter
  end

  module ClassMethods
    def rebuild

    end
  end
end