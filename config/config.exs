import Config

config :lm_eval, LmEval.Repo,
  database: "lm_eval_repo",
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  hostname: "localhost"

config :lm_eval, ecto_repos: [LmEval.Repo]
