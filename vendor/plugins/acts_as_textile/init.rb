require File.dirname(__FILE__) + '/lib/acts_as_textile'

ActiveRecord::Base.send(:include, Asscore::ActsAsTextile)
