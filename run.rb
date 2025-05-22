#!/usr/bin/env ruby

# Load the gems and environment variables from .env file.
Dir.chdir(__dir__) do
  require "bundler/setup"
  require "dotenv/load"
end

require "ruby_llm"
require_relative "src/agent"


RubyLLM.configure do |config|

  # Ollama ignores the key but RubyLLM insists on *something* non-empty
  config.openai_api_key  = ENV.fetch("OPENAI_API_KEY", "ollama")

  # Point RubyLLM’s OpenAI client at Ollama’s /v1 adapter
  config.openai_api_base = ENV.fetch("OPENAI_API_BASE",
                                     "http://localhost:11434/v1")

  # Optional – pick the model you just pulled
   config.default_model = "devstral-14b-100k:latest"
  #config.default_model = "qwen3:32b"
  #config.default_model = "deepseek-r1:32b"

end

Agent.new.run
