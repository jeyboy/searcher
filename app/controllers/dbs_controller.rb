require 'dumper'

class DbsController < ApplicationController
  def create
    `rake db:seed:dump EXCLUDE=[created_at, updated_at]`
    send_file Rails.root.join('db', 'seeds.rb')
  end

  def update
    file = params[:db][:file].tempfile.path
    ::Dumper.restore(file)
  end
end
