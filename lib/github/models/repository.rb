require 'github/models/base_model'

module GitHub
  class Repository < BaseModel
    def self.repositories_from_hashes(h)
      h.map { |repository_attrs| from_hash(repository_attrs) }
    end

    def owner
      owner = @table[:owner]
      @owner ||= String === owner ? GitHub.user(owner) : GitHub::User.new(owner)
    end

    def branches
      @branches ||= GitHub.branches(self.owner.login, self.name)
    end

    def forks
      @forks ||= GitHub.forks(self.owner.login, self.name)
    end

    def commit(id)
      GitHub.commit(owner.login, self.name, id)
    end
    
    def commits(branch = nil, options = {})
      GitHub.commits owner.login, self.name, branch, options
    end
  end
end
