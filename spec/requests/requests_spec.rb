require 'rails_helper'

RSpec.describe 'Requests API', type: :request do
  # initialize test data
  let!(:requests) { create_list(:request, 10) }
  let(:request) { requests.first.id }

  # Test suite for GET /todos
  describe 'GET /requests' do
    # make HTTP get request before each example
    before { get '/requests' }

    it 'returns requests' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /requests/:id' do
    before { get "/requests/#{request_id}" }

    context 'when the record exists' do
      it 'returns the request' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(request_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:request_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Request/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /requests' do
    # valid payload
    let(:valid_attributes) { { code: 'Learn Elm', status: 'saved' } }

    context 'when the request is valid' do
      before { post '/requests', params: valid_attributes }

      it 'creates a request' do
        expect(json['code']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/requests', params: { code: 'Learn Elm' } }

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
  describe 'PUT /requests/:id' do
    let(:valid_attributes) { { code: 'Learn Elm', status: 'Registered' } }

    context 'when the record exists' do
      before { put "/requests/#{request_id}", params: valid_attributes }

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
