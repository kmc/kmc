require 'rugged'

module Kosmos
  class Versioner
    class << self
      INIT_COMMIT_MESSAGE = "I: Initialize Kosmos"

      def init_repo(path)
        GitAdapter.init_repo(path)
        GitAdapter.commit_all(path, INIT_COMMIT_MESSAGE)
      end

      def prepare_for_install(path, formula)
        GitAdapter.commit_everything(repo(path), formula.title)
      end

      # def reset_to_preinstall(path, formula)
      #   repo = repo(path)

      #   # this commit is HEAD~
      #   previous_commit = repo.lookup(repo.head.target).parents.first

      #   repo.reset(:hard, previous_commit)
      # end
    end
  end
end
