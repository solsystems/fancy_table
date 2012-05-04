module FancyTable
  class Railtie < Rails::Railtie
    config.before_configuration do |app|
      app.paths['app/views'] << File.expand_path('../../../app/views', __FILE__)
      app.paths['app/assets'] << File.expand_path('../../../app/assets', __FILE__)
    end

    initializer "fancy_table.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
