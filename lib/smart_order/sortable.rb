class SmartOrder::Sortable
  def smart_order(key, desc)
    last_class = self
    joins = []
    conditions = []
    sum_column = nil

    while matches = key.match(/^(?<first>[^\.]*)\.(?<rest>.*)$/)
      first = matches[:first]
      rest = matches[:rest]

      if first.match(/^(.*)=(.*)$/)
        conditions << last_class.arel_table[$1].eq($2)
      elsif association = last_class.reflect_on_association(first.to_sym)
        joins << first
        last_class = association.klass
      elsif rest == 'sum'
        sum_column = first
      end
      key = rest
    end

    scope = scoped
    if association = last_class.reflect_on_association(key.to_sym)
      joins << key
      last_class = association.klass
      key = last_class.default_order_column
    end

    unless joins.empty?
      join = Squeel::Nodes::Join.new(joins.shift.to_sym).outer
      while nextjoin = joins.shift
        join = join.send(nextjoin.to_sym).outer
      end
      scope = scope.joins join
    end

    conditions.each do |condition|
      scope = scope.where condition
    end

    order =
      if key == 'sum' or key == 'count'
        group_bys = column_names.map{|c| "#{table_name}.#{c}"}
        scope = scope.group(group_bys)
        if key == 'count'
          "COUNT(#{last_class.table_name}.id)"
        else
          "SUM(#{last_class.table_name}.#{sum_column})"
        end
      elsif last_class.respond_to?(special_method = "order_by_#{key}")
        last_class.send special_method
      else
        "#{last_class.table_name}.#{key}"
      end

    order += " DESC" if desc
    scope.order(order)
  end


  #private

  def default_order_column
    columns.map(&:name).include?('name') ? 'name' : 'id'
  end

end
