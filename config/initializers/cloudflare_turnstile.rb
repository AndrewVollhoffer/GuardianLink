RailsCloudflareTurnstile.configure do |option|
  option.site_key = ENV.fetch("CLOUDFLARE_TURNSTILE_SITE_KEY")
  option.secret_key = ENV.fetch("CLOUDFLARE_TURNSTILE_SECRET_KEY")
  option.fail_open = true
end
