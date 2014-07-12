require "paperclip/railtie"
Paperclip::Railtie.insert

# https://github.com/thoughtbot/paperclip/issues/1470
require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
