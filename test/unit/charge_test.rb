# frozen_string_literal: true

require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:organization)
  should belong_to(:issuing_participant)
  should belong_to(:receiving_participant)
  should belong_to(:creating_participant)
  should belong_to(:charge_type)

  # Validations

  should validate_presence_of(:charged_at)
  should validate_presence_of(:issuing_participant)
  should validate_presence_of(:organization)
  should validate_presence_of(:charge_type)
  should validate_presence_of(:amount)

  should validate_numericality_of(:amount)

  # Methods
  context 'With a proper context, ' do
    setup do
      # Create a charges
      @fine = FactoryGirl.create(:charge, is_approved: false)
      @fine2 = FactoryGirl.create(:charge, is_approved: false)
      @fine3 = FactoryGirl.create(:charge, is_approved: true)
    end

    teardown do
    end

    should 'show that all factories are properly created' do
      assert_equal 3, Charge.all.size
    end

    should 'show that pending scope works' do
      assert_equal 2, Charge.pending.size
    end

    should 'show that approved scope works' do
      assert_equal 1, Charge.approved.size
    end

    context 'Testing charges' do
      should 'not let charge with string for amount value be created' do
        charge1 = FactoryGirl.build(:charge, amount: 'a')
        deny charge1.valid?
      end
    end
  end
end
