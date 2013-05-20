require 'active_support/concern'
module ActiveRecord
  module Blockwhere
    module ArelNodeOperations
      def &(other)
        self.and(other)
      end

      def |(other)
        self.or(other)
      end

      def !
        self.not
      end

      def empty?
        false
      end
    end
    
    # fix https://github.com/techscore/activerecord-blockwhere/issues/2
    module RevertArelNodeOperations
      extend ActiveSupport::Concern
      included do
        undef_method :&, :|, :empty?
        define_method(:!, &Object.method(:!))
      end
    end
  end
end
