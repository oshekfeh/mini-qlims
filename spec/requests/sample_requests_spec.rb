require 'rails_helper'

RSpec.describe 'SampleRequests API', type: :request do
  # initialize test data
  let!(:sample_requests) { create_list(:sample_request, 10) }
  let(:sample_request_id) { sample_requests.first.id }
  let!(:samples) { create_list(:sample, 5, sample_request_id: sample_requests.first.id) }
  let!(:test_type) { create(:test_type) }
  let!(:sample_type) { create(:sample_type) }
  let!(:unit) { create(:unit) }

  # Test suite for GET /todos
  describe 'GET /sample_requests' do
    # make HTTP get request before each example
    before { get '/sample_requests' }

    it 'returns sample_requests' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    before do
      # samples.first.test_type << test_type
      # samples.first.sample_type << sample_type
      # samples.first.unit << unit
      sample_requests.first.samples << samples
    end

    it 'Check that sample_requests retrieve sample' do
      expect(json[0]['samples'].size).to eq(5)
      expect(json[0]['samples'][0]['sample_type_id']).should_not be_nil
      expect(json[0]['samples'][0]['test_type_id']).should_not be_nil
      expect(json[0]['samples'][0]['unit_id']).should_not be_nil
    end

    it 'Check that sample_requests send empty sample array is there is no assiociation' do
      expect(json[1]['samples'].size).to eq(0)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /sample_requests/:id' do
    before { get "/sample_requests/#{sample_request_id}" }

    context 'when the record exists' do
      it 'returns the request' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(sample_request_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:sample_request_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find SampleRequest/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /sample_requests' do
    # valid payload
    let(:valid_attributes) { { code: 'Learn Elm', status: 'saved' } }

    context 'when the request is valid' do
      before { post '/sample_requests', params: valid_attributes }

      it 'creates a sample request' do
        expect(json['code']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the sample request is invalid' do
      before { post '/sample_requests', params: { code: 'Learn Elm' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Status can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /sample_requests/:id' do
    let(:valid_attributes) { { code: 'Learn Elm', status: 'Registered' } }

    context 'when the record exists' do
      before { put "/sample_requests/#{sample_request_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  #IDEA make the request can be deleted in case that it's not submitted yet.
  # Test suite for DELETE /todos/:id
  # describe 'DELETE /todos/:id' do
  #   before { delete "/todos/#{todo_id}" }
  #
  #   it 'returns status code 204' do
  #     expect(response).to have_http_status(204)
  #   end
  # end
end
