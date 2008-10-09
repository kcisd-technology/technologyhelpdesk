require File.dirname(__FILE__) + '/test_helper'

class ActsAsTextileTest < ActsAsTextileTestCase
  
  context 'acts_as_textile' do
    
    setup do
      @textile_text = "h2. Textile Test Text"
      class ::Page < ActiveRecord::Base
        acts_as_textile :body
      end
      @page = Page.create!(:title => 'Blah', :body => @textile_text)
    end
    
    should "have a RedCloth object returned for the column value" do
      assert_kind_of RedCloth::TextileDoc, @page.body
    end
    
    should "return original textile text for a `to_s` method call on the column value" do
      assert_equal @textile_text, @page.body.to_s
    end
    
    should "return formated html for a `to_html` method call on the column value" do
      assert_match(/<h2>Textile Test Text<\/h2>/, @page.body.to_html)
    end
   
    teardown do
      @textile_text, @page = nil
      Page.delete_all
    end
    
  end
  
end
