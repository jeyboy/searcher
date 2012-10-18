class ModelToSeed
  def self.perform(model)
    #reflections = model.name.reflections
    attrs = model.content_columns.select {|o| !o.name[/ated_at/] }.map(&:name)
    model.all.inject("") do |res, obj|
      res << <<-EOF
        temp = #{model.name}.new
        #{attrs.map {|attr| "temp.#{attr}=#{obj.send(attr)}"}.join("\r\n")}
        temp.save\r\n
      EOF
    end
  end
end