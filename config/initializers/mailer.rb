if ENV["RAILS_ENV"] == "production"
  Resend.api_key = ENV.fetch("RESEND_API_KEY")
end
