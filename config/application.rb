require_relative 'boot'

require 'rails/all'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

Bundler.require(*Rails.groups)

module CourseItransition
  class Application < Rails::Application
    config.i18n.default_locale = :en
  end
end
