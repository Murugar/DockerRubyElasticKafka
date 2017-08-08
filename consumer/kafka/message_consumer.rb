require "#{Dir.pwd}/config/elastic"
require "#{Dir.pwd}/config/kafka"

class MessageConsumer
  def initialize
    @topic = "messages_test"
    @consumer = Consumer.new
    @elastic = ElasticConnector.new(index: "test", mapping: "messages_test")
  end

  def start_stream
    @consumer.consume(@topic) do |message|
      puts message.value
      @elastic.insert(message.value)
    end
  end
end

require "#{Dir.pwd}/config/kafka"
