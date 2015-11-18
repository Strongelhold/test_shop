module Service
  extend ActiveSupport::Concern

  included do
    def self.call(*args)
      new(*args).call
    end

    def self.query(*args)
      new(*args).query
    end
    
    def self.successful?(*args)
      new(*args).successful?
    end
  end
end
