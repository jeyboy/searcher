require 'dumper'

class DbsController < ApplicationController
  def create
    ::Dumper.dump(ActiveRecord::Base.connection) unless File.exist?(::Dumper.file_path)
    send_file(::Dumper.file_path)
  end

  def update
    file = params[:db][:file].tempfile.path
    ::Dumper.restore(file)
  end
end
