module ChurchCommunityBuilder

  class AttendanceProfileListReader < ApiReader

    def initialize(options = {})
      filter = options[:filter]
      @url_data_params = options[:url_data_params]
    end
    
  end
end
