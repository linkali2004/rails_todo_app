class ApplicationController < ActionController::Base
        include Devise::Controllers::Helpers
      
    include CableReady::Broadcaster
end
