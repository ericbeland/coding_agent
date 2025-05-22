require "ruby_llm"
require_relative "tools/read_file"
require_relative "tools/list_files"
require_relative "tools/edit_file"
require_relative "tools/run_shell_command"

class Agent
  def initialize
    @chat = RubyLLM.chat(
      provider: :openai,          # use the OpenAI dialect
      model:    "devstral-14b-100k:latest",  # any model name that Ollama exposes
      #  model:    "deepseek-r1:32b",
      assume_model_exists: true   # skip the registry lookup
    )

    @chat.with_tools(Tools::ReadFile, Tools::ListFiles, Tools::EditFile, Tools::RunShellCommand)
  end

  def run
    puts "Chat with the agent. Type 'exit' to ... well, exit"
    loop do
      print "> "
      user_input = gets.chomp
      break if user_input == "exit"

      response = @chat.ask user_input
      puts response.content
    end
  end
end
