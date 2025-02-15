# frozen_string_literal: true

class EventTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:event_type)

  # Scopes
  context 'With a proper context, ' do
    setup do
      @type1 = FactoryGirl.create(:event_type, display: false)
      @type2 = FactoryGirl.create(:event_type, display: true)
      @event1 = FactoryGirl.create(:event, is_done: true, event_type_id: @type1.id)
      @event2 = FactoryGirl.create(:event, is_done: false, event_type_id: @type2.id)
    end

    teardown do
    end

    # scopes
    should 'show that displayable scope works' do
      assert_equal 1, Event.displayable.size
    end
  end
end
