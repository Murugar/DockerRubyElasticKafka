require "kafka"

class Consumer
  attr_reader :kafka

  def initialize
    @kafka = Kafka.new(
      seed_brokers: ["localhost:9092"],
      client_id: "ruby-elastic-application"
    )
  end

  def consume(topic)
    @kafka.each_message(topic: topic) do |message|
      yield(message)
    end
  end
end
