# frozen_string_literal: true
module Api
  class ApplicationController < JSONAPI::ResourceController
    skip_before_action :ensure_correct_media_type
    skip_before_action :ensure_valid_accept_media_type
    protect_from_forgery with: :null_session
  end
end
