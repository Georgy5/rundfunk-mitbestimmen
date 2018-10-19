require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe GeocodeUserJob, type: :job do
  around(:each) do |example|
    Sidekiq::Testing.inline! do
      example.run
    end
  end
  subject { GeocodeUserJob.perform_later(auth0_uid) }

  context 'missing auth0_uid' do
    let(:auth0_uid) { nil }
    it { expect { subject }.not_to raise_error }
  end

  context 'ipstack API key' do
    let(:auth0_uid) { 'whatever' }
    before { create(:user, auth0_uid: auth0_uid) } # now we would run into a request

    it 'by default is a placeholder' do
      expect(Geocoder.config[:ipstack][:api_key]).to eq('IPSTACK_API_KEY')
    end

    context 'missing' do
      before { Geocoder.config[:ipstack][:api_key] = nil }
      it { expect { subject }.not_to raise_error }
    end

    context 'as a placeholder' do
      it { expect { subject }.not_to raise_error }
    end
  end

  context 'no user for auth0_uid' do
    let(:auth0_uid) { 'no_user_for_that_auth0_uid' }
    it { expect { subject }.not_to raise_error }
  end
end
