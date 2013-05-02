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
  end
end
