require 'clockwork'
require './config/boot'
require './config/environment'

# TODO No tests for this. When change is needed here it will not work!
module Clockwork
  error_handler do |error|
    Rollbar.error(error)
  end

  every(1.hour, 'Downloaded updates from BTN Feed', thread: true) do
    UpdateAllFeedsJob.perform_later
  end
end
