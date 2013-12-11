require 'backuper'

class DbsController < ApplicationController
  def create
    ::Backuper.dump(ActiveRecord::Base.connection)
    send_file(::Backuper.file_path)
  end

  def update
    file = params[:db][:file].tempfile.path
    ::Backuper.restore(file)
  end
end
