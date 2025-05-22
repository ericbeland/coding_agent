require "ruby_llm/tool"

module Tools
  class GitCreateBranch < RubyLLM::Tool
    description <<~DESCRIPTION
      Creates a new Git branch and switches to it.
    DESCRIPTION
    param :branch_name, desc: "The name of the branch to create and switch to"

    def execute(branch_name:)
      system("git branch #{branch_name}")
      system("git checkout #{branch_name}")
      { success: "Branch #{branch_name} created and switched to." }
    rescue => e
      { error: e.message }
    end
  end

  # more tool classes for git go here

end

