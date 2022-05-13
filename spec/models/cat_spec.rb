require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe "Create cat Validations" do

    it 'must contain an name' do
      cat = Cat.create(
        age: 42,
        enjoys: 'surfing on the beach with all the bro cats',
        image:'https://cat-pic.jpg'
      )
      expect(cat.errors[:name]).to_not be_empty
    end

    it 'must contain an age' do
      cat = Cat.create(
        name: 'Toby Keith',
        enjoys: 'surfing on the beach with all the bro cats',
        image:'https://cat-pic.jpg'
      )
      expect(cat.errors[:age]).to_not be_empty
    end

    it 'must contain an enjoys' do
      cat = Cat.create(
        name: 'Toby Keith',
        age: 42,
        image:'https://cat-pic.jpg'
      )
      expect(cat.errors[:enjoys]).to_not be_empty
    end

    it 'must contain an image' do
      cat = Cat.create(
        name: 'Toby Keith',
        age: 42,
        enjoys: 'surfing on the beach with all the bro cats',
      )
      expect(cat.errors[:image]).to_not be_empty
    end

    it 'enjoys must have minimum length of ten' do
      cat = Cat.create(
        name: 'Toby Keith',
        age: 42,
        enjoys: 'surfing',
        image:'https://cat-pic.jpg'
      )
      expect(cat.errors[:enjoys]).to_not be_empty
    end
    
  end
end
