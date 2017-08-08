require "#{Dir.pwd}/kafka/message_consumer"

consumer = MessageConsumer.new
consumer.start_stream
