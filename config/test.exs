import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cross_commerce_test, CrossCommerceTestWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "IpPv+up/Ij1BuoQlUIraF7ieb7O2vb4szWDltpxztpPJIxvO0ZbzwHpSzTNBtvH0",
  server: false

# In test we don't send emails.
config :cross_commerce_test, CrossCommerceTest.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
