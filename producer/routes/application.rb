require "sinatra"
require "sinatra/namespace"
require "#{Dir.pwd}/kafka/message_producer"

class AppRoutes < Sinatra::Application
  register Sinatra::Namespace

  get "/" do
    halt 200, JSON.pretty_generate({ "message" => "Hello World" })
  end

  not_found do
    halt 404, JSON.pretty_generate({ "message" => "This route does not exist." })
  end

  namespace "/api" do
    before do
      @producer = MessageProducer.new
    end

    post "/messages" do
      begin
        @params = JSON.parse(request.body.read)
        @producer.do(@params)
        halt 201
      rescue JSON::ParserError => e
        halt 500, JSON.pretty_generate({ "message" => e.message })
      end
    end
  end
end
