use Mix.Config

# Read the API key from the environment
config :easy_post, api_key: System.get_env("EASY_POST_KEY")

# Print only warnings and errors during test
config :logger, level: :warn
