require 'github/models/base_model'

module GitHub
  class Repository < BaseModel
    def self.repositories_from_hashes(h)
      h.map { |repository_attrs| from_hash(repository_attrs) }
    end

    def branches
      @branches ||= GitHub.branches(self.owner, self.name)
    end

    def network
      @network ||= GitHub.network(self.owner, self.name)
    end

    def commit(id)
      GitHub.commit(self.owner, self.name, id)
    end
  end
end
