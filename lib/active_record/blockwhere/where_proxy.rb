require 'active_support'

module ActiveRecord
  module Blockwhere
    class WhereProxy < ActiveSupport::BasicObject
      attr_reader :relation, :context

      def self.where(relation, context = nil, &block)
        proxy = new(relation, context)
        condition = proxy.instance_eval(&block)
        condition ? proxy.relation.where(condition) : proxy.relation
      end

      def initialize(relation, context = nil)
        @relation = relation
        @context  = context
      end

      def method_missing(name, *args, &block)
        if @relation.columns_hash.key?(name.to_s)
          return @relation.arel_table[name]
        end
        reflection = @relation.reflections[name]
        if ::ActiveRecord::Reflection::AssociationReflection === reflection
          @relation = @relation.joins(name) unless @relation.joins_values.include?(name)
          return WhereProxy.new(reflection.klass.scoped, @context)
        end
        if @context && @context.respond_to?(name)
          return @context.__send__(name, *args, &block)
        end
        @relation.__send__(name, *args, &block)
      end
    end
  end
end
