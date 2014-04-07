module SalsaLabs
  class Client
    attr_accessor :api_client

    def initialize(credentials)
      api_client = SalsaLabs::ApiClient.new(credentials)
    end

    def supporters(params = {})
      SupportersFetcher.new(params).fetch
    end
  end
end