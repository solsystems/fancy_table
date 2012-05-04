module FancyTable
  module ViewHelpers
    def wrap_if(condition, symbol, *args, &block)
      if condition
        send symbol, *args, &block
      else
        capture(&block)
      end
    end

    def wrap_unless(condition, symbol, *args, &block)
      wrap_if(!condition, symbol, *args, &block)
    end

    def link_to_object(object, label_attribute = nil)
      if object.class.respond_to? :table_name
        pathmethod = "#{object.class.table_name.singularize}_path"
        if respond_to? pathmethod
          link_to object.send( label_attribute || object.class.default_order_column ), send(pathmethod, object)
        else
          object.to_s
        end
      else
        object.to_s
      end
    end

    def fancy_table(objects, options = {})
      options.merge! objects: objects
      render partial: 'fancy_table/fancy_table', locals: options
    end
  end
end

