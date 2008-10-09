require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require File.expand_path( File.join(File.dirname(__FILE__), %w[.. init]) )

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
 
def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :pages do |t|
      t.column :title, :string
      t.column :body, :text
      t.timestamps
    end
  end
end
 
def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end
 
class ActsAsTextileTestCase < ActiveSupport::TestCase
  def setup
    setup_db
  end
  
  def teardown
    teardown_db
  end
end
