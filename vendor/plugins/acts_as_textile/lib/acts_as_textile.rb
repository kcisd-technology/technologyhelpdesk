require 'redcloth'

module Asscore
  module ActsAsTextile
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      
      def acts_as_textile(*columns)
        columns.each do |col|
          class_eval <<-EOV
            def #{col.to_s}
              if @#{col.to_s}
                unless self.#{col.to_s}_changed?
                  return @#{col.to_s}
                end
              end
              @#{col.to_s} = RedCloth.new(self['#{col.to_s}'].to_s)
            end
          EOV
        end
      end
      
    end
    
  end
end

