require "elasticsearch"
require "elasticsearch/xpack"
require "json"

class ElasticConnector
  def initialize(index: '', mapping: '')
    @index = index
    @mapping = mapping
    @client = Elasticsearch::Client.new url: "http://elastic:changeme@localhost:9200"
    check_index
  end

  def insert(json)
    @client.create index: @index, type: @mapping, id: rand() * 1000, body: JSON.parse(json)
  end

  private
  def check_index
    unless @client.indices.exists? index: @index
      create_index
    end
  end

  def create_index
    index_config = {
      settings: {
        index: {
          number_of_shards: 1,
          number_of_replicas: 0
        }
      },
      mappings: {
        "#{@mapping}": {
          _all: {
            enabled: false
          },
          properties: {
            message: {
              type: "text"
            },
            user: {
              type: "text"
            }
          }
        }
      }
    }

    @client.indices.create index: @index, body: index_config
  end
end
