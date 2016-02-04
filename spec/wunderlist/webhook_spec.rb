require 'spec_helper'

describe Wunderlist::Webhook do
  let(:api) { Wunderlist::API.new }
  let(:webhook) { described_class.new }

  describe "a webhook" do
    it 'has a hash representation' do
      expect(webhook.to_hash.keys).to eq(%w(
        id
        list_id
        created_by_id
        processor_type
        url
        created_at
        configuration
        )
      )
    end

    it "has a model name" do
      expect(webhook.model_name).to eq 'webhook'
    end
  end
end
