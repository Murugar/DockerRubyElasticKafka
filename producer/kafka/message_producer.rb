require "#{Dir.pwd}/config/kafka"

class MessageProducer
  def initialize
    @topic = "messages_test"
    @producer = Producer.new
  end

  def do(params = {})
    content = params.to_json
    @producer.write(content, @topic)
  end
end
