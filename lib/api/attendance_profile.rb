module ChurchCommunityBuilder

  include Enumerable

  class AttendanceProfile < ApiObject

    ccb_attr_accessor :id,
                      :name,
                      :occurrence,
                      :did_not_meet,
                      :topic,
                      :notes,
                      :prayer_requests,
                      :info,
                      :attendees,
                      :head_count

    def initialize(json_data = nil, options = {})
      initialize_from_json_object(json_data) unless json_data.nil?

      if json_data["ccb_api"].nil?
        batch_json = json_data
      else
        batch_json = json_data["ccb_api"]["response"]["batches"]["batch"]
      end

      initialize_from_json_object(batch_json) unless batch_json.nil?
      @id = @id.to_i
      @occurrence = DateTime.parse(@occurrence)

      if @attendees
        @attendees = Array.wrap(@attendees['attendee'])
      end
    end
  end

end
