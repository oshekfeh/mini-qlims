require 'rails_helper'

RSpec.describe 'Units API', type: :request do
  # initialize test data
  let!(:units) { create_list(:unit, 10) }
  let(:unit_id) { units.first.id }

  # Test suite for GET /todos
  describe 'GET /units' do
    # make HTTP get request before each example
    before { get '/units' }

    it 'returns units' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /units/:id' do
    before { get "/units/#{unit_id}" }

    context 'when the record exists' do
      it 'returns the unit' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(unit_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:unit_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Unit/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /units' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm'} }

    context 'when the request is valid' do
      before { post '/units', params: valid_attributes }

      it 'creates a unit' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/units', params: {  } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  #TODO consider test that unit code can't be modifiable
  # Test suite for PUT /todos/:id
  describe 'PUT /units/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/units/#{unit_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  #TODO consider test that sample type can't be deleted
  # Test suite for DELETE /todos/:id
  # describe 'DELETE /units/:id' do
  #   before { delete "/units/#{unit_id}" }
  #
  #   it 'returns status code 204' do
  #     expect(response).to have_http_status(204)
  #   end
  # end
end
