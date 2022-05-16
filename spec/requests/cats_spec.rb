require 'rails_helper'

RSpec.describe 'Cats', type: :request do
  describe 'GET /index' do
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

  describe 'POST /create' do
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

  describe 'PATCH /update' do
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

      updated_cat_params = {
        cat: {
          name: 'Toast',
          age: 3,
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)
      expect(updated_cat.age).to eq(3)
    end
  end

  describe 'DELETE /destroy' do
    it 'can delete an existing cat' do
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
      delete "/cats/#{cat.id}"
      cat = Cat.all
      expect(response).to have_http_status(200)
      expect(cat).to be_empty
    end
  end

  describe 'create request validations' do
    it "doesn't create a cat without a name" do
      cat_params = {
        cat: {
          age: 2,
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      post '/cats', params: cat_params
      cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat_response['name'].first).to eq("can't be blank")
    end

    it "doesn't create a cat without an age" do
      cat_params = {
        cat: {
          name: 'Toast',
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      post '/cats', params: cat_params
      cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat_response['age'].first).to eq("can't be blank")
    end

    it "doesn't create a cat without an enjoys" do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          image: 'http://www.catpics.com'
        }
      }
      post '/cats', params: cat_params
      cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat_response['enjoys'].first).to eq("can't be blank")
    end

    it "doesn't create a cat without an image" do
      cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'allll the attention'
        }
      }
      post '/cats', params: cat_params
      cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat_response['image'].first).to eq("can't be blank")
    end
  end

  describe 'update request validations' do
    it "doesn't update a cat without a name" do
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

      updated_cat_params = {
        cat: {
          name: '',
          age: 2,
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(updated_cat_response['name'].first).to eq("can't be blank")
    end

    it "doesn't update a cat without an age" do
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

      updated_cat_params = {
        cat: {
          name: 'Toast',
          age: '',
          enjoys: 'allll the attention',
          image: 'http://www.catpics.com'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(updated_cat_response['age'].first).to eq("can't be blank")
    end

    it "doesn't update a cat without an enjoys" do
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

      updated_cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: '',
          image: 'http://www.catpics.com'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(updated_cat_response['enjoys'].first).to eq("can't be blank")
    end

    it "doesn't update a cat with an enjoys that is less than 10 characters" do
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

      updated_cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'sleep',
          image: 'http://www.catpics.com'
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(updated_cat_response['enjoys'].first).to eq("is too short (minimum is 10 characters)")
    end

    it "doesn't update a cat without an image" do
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

      updated_cat_params = {
        cat: {
          name: 'Toast',
          age: 2,
          enjoys: 'allll the attention',
          image: ''
        }
      }
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat_response = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(updated_cat_response['image'].first).to eq("can't be blank")
    end
  end
end
