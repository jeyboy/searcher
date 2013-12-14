require 'dumper'

class DbsController < ApplicationController
  def create
    `rake db:seed:dump EXCLUDE=[]`
    send_file Rails.root.join('db', 'seeds.rb')
    #::Dumper.dump(ActiveRecord::Base.connection) unless File.exist?(::Dumper.file_path)
    #send_file(::Dumper.file_path)
  end

  def update
    file = params[:db][:file].tempfile.path
    ::Dumper.restore(file)
  end
end
