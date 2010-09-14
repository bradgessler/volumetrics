require 'sinatra'

class Volume
  
  InvalidLevelError = Class.new(ArgumentError)
  
  class << self
    def level=(level)
      level = level.to_i
      raise Volume::InvalidLevelError unless (0..100).include?(level)
      osa "set volume output volume #{level}"
    end
    
    def level
      osa('get (output volume of (get volume settings))').to_i
    end
    
  private
    def osa(script)
      `osascript -e '#{script}'`
    end
  end
  
end

post '/' do
  begin
    Volume.level = params[:level]
    "The volume is now set at #{params[:level]}\n"
  rescue Volume::InvalidLevelError
    halt "Hey doofus, the volume should be between 0 and 100. Easy on the 100 side, you don't want blown speakers on your hands.\n"
  end
end

get '/' do
  "Volume level is currently #{Volume.level}. Want to set the volume? curl -d 'level=25' 'http://#{env['HTTP_HOST']}'"
end