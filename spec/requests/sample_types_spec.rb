require 'rails_helper'

RSpec.describe 'SampleTypes API', type: :request do
  # initialize test data
  let!(:sample_types) { create_list(:sample_type, 10) }
  let(:sample_type_id) { sample_types.first.id }
  let(:test_type) { create_list(:test_type, 5) }

  # Test suite for GET /todos
  describe 'GET /sample_types' do
    # make HTTP get request before each example
    before { get '/sample_types' }

    it 'returns sample_types' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /sample_types/:id' do
    before do
      sample_types.first.test_types << test_type
    end
    before { get "/sample_types/#{sample_type_id}" }

    context 'when the record exists' do
      it 'returns the sample_type' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(sample_type_id)
      end

      it 'returns the assigned test_types' do
        expect(json['test_types'].size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:sample_type_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find SampleType/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /sample_types' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm'} }
    let(:attributes_with_assignment) { { name: 'Omar Shekfeh', test_types: [{:id => test_type[0].id, :name => test_type[0].name}, {:id => test_type[1].id, :name => test_type[1].name}] } }

    context 'when the request is valid' do
      before { post '/sample_types', params: valid_attributes }

      it 'creates a sample_type' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is valid and assigned to test_types' do
      before { post '/sample_types', params: attributes_with_assignment }

      it 'creates a sample_type' do
        expect(json['name']).to eq('Omar Shekfeh')
        expect(json['test_types'].size).to eq(2)
      end
    end

    context 'when the request is invalid' do
      before { post '/sample_types', params: {  } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  #TODO consider test that sample_type code can't be modifiable
  # Test suite for PUT /todos/:id
  describe 'PUT /sample_types/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }
    let(:attributes_with_assignment) { { name: 'Omar Shekfeh', test_types: [{:id => test_type[0].id, :name => test_type[0].name}, {:id => test_type[1].id, :name => test_type[1].name}] } }

    context 'when the record exists' do
      before { put "/sample_types/#{sample_type_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'When the record exists with association' do
      before do
        sample_types.first.test_types << test_type
        put "/sample_types/#{sample_type_id}", params: attributes_with_assignment
      end

      it 'updates the record' do
        expect(response.body).to be_empty
        expect(sample_types.first.test_types.size).to eq(2)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  #TODO consider test that sample type can't be deleted
  # Test suite for DELETE /todos/:id
  # describe 'DELETE /sample_types/:id' do
  #   before { delete "/sample_types/#{sample_type_id}" }
  #
  #   it 'returns status code 204' do
  #     expect(response).to have_http_status(204)
  #   end
  # end
end
