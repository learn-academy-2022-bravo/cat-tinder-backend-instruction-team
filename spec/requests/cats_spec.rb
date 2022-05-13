require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it 'return a list of all cats' do
      Cat.create(
        name: 'Toast',
        age: 2,
        enjoys: 'allll the attention',
        image: 'http://www.catpics.com'
      )
      get '/cats'
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq(1)
    end
  end

  describe "POST /create" do
    it 'can create a cat' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      expect(response).to have_http_status(200)
      expect(cat.name).to eq('Toast')
      expect(cat.age).to eq(2)
      expect(cat.enjoys).to eq('allll the attention')
      expect(cat.image).to eq('http://www.catpics.com')
    end
  end

  describe "PATCH /update" do
    it 'can update an existing cat' do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first

      update_cat_params = {
        cat: {
          name: 'Toast',
          age: 3,
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      patch "/cats/#{cat.id}", params: update_cat_params
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)
      expect(updated_cat.age).to eq(3)
    end
  end
  describe 'Cat create request validations' do
    it "doesn't create a cat without a name" do
      cat_params = {
        cat: {
          age: 2,
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      post '/cats', params: cat_params
      # expect(response.status).to eq 422
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
    end
    it "doesn't create a cat without a age" do
      cat_params = {
        cat: {
          name: 'Toast',
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      post '/cats', params: cat_params
      # expect(response.status).to eq 422
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body)
      expect(json['age']).to include "can't be blank"
    end
    it "doesn't create a cat without a enjoys" do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          image: 'http://www.catpics.com'
        }
      }
      post '/cats', params: cat_params
      # expect(response.status).to eq 422
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body)
      expect(json['enjoys']).to include "can't be blank"
    end
    it "doesn't create a cat without a image" do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'allll the attention'
        }
      }
      post '/cats', params: cat_params
      # expect(response.status).to eq 422
      expect(response).to have_http_status(422)

      json = JSON.parse(response.body)
      expect(json['image']).to include "can't be blank"
    end
  end
end
