class ActionController::Base
  def fancy_table(objects, options = {})
    order = options[:order] || params[:order_by]
    objects.define_singleton_method(:fancy_table_order) { order }
    klass = objects.first.class

    headers = options[:headers] ||
      begin
        names = klass.column_names - %w{id created_at updated_at}
        names.map { |name| name.sub(/_id$/, '') }.map_hash{ |name| [name, name.titleize] }
      end

    objects.define_singleton_method(:fancy_table_headers) { headers }

    if order =~ /\A(#{headers.keys.join('|')})( desc)?\Z/
      objects=objects.smart_order order
    end

    page = options[:page] || params[:page]
    limit = options[:limit]
    if limit || page
      page ||= 1
      objects = objects.page(page.to_i)
      objects = objects.per(limit) if limit
    end

    objects
  end
end
