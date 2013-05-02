require "active_record/blockwhere/where_proxy"
require "active_record/blockwhere/arel_node_operations"

module ActiveRecord
  module Blockwhere
    def where(*args, &block)
      relation = args.empty? ? self : super(*args)
      relation = WhereProxy.where(relation, block.binding.eval('self'), &block) if block
      relation
    end
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Relation.send :include, ActiveRecord::Blockwhere
  Arel::Nodes::Node.send      :include, ActiveRecord::Blockwhere::ArelNodeOperations
end