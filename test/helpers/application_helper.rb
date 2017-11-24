class Minitest::Test
  def application_instance
    @app ||= Middleman::Application.server.inst do
      set :environment, :development
      set :show_exceptions, false
    end
  end
end
