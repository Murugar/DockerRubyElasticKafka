require "kafka"

class Producer
  attr_reader :kafka

  def initialize
    @kafka = Kafka.new(
      seed_brokers: ["localhost:9092"],
      client_id: "ruby-elastic-application",
    )
  end

  def write(content, topic)
    producer = @kafka.producer
    producer.produce(content, topic: topic)
    producer.deliver_messages
  end
end
