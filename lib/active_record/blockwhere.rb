require "active_record/blockwhere/where_proxy"
require "active_record/blockwhere/arel_node_operations"

module ActiveRecord
  module Blockwhere
    def where(*args)
      relation = args.empty? ? self : super(*args)
      if block_given?
        block = Proc.new
        relation = WhereProxy.where(relation, block.binding.eval('self'), &block)
      end
      relation
    end
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Relation.send :include, ActiveRecord::Blockwhere
  Arel::Nodes::Node.send      :include, ActiveRecord::Blockwhere::ArelNodeOperations
end
