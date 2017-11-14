# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :logger, level: :debug
config :lychrel_numbers, interface: :eth0

config :lychrel_numbers, LychrelNumbers.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "lychrel_numbers",
  username: "postgres",
  password: "postgres",
  hostname: "nomokoslave2.nomoko.lan"

config :lychrel_numbers, ecto_repos: [LychrelNumbers.Repo]

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"
config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(key_mgmt)
  ],
  eth0: [
    ipv4_address_method: :dhcp
  ]

config :bootloader,
  init: [:nerves_runtime, :nerves_network],
  app: :lychrel_numbers

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"
