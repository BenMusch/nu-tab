# frozen_string_literal: true
module Api
  class ApplicationController < ::ApplicationController
    include JSONAPI::ActsAsResourceController
    protect_from_forgery with: :null_session
  end
end
