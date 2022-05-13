require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe "Create cat Validations" do
    it "must contain an name" do
      cat = Cat.create age:42, enjoys:'surfing on the beach with all the bro cats', image:'https://wp.usatodaysports.com/wp-content/uploads/sites/88/2020/06/screen-shot-2020-06-03-at-9.47.38-am.jpg'
      expect(cat.errors[:name]).to_not be_empty
    end
    it "must contain an age" do
      cat = Cat.create name:'Toby Keith', enjoys:'surfing on the beach with all the bro cats', image:'https://wp.usatodaysports.com/wp-content/uploads/sites/88/2020/06/screen-shot-2020-06-03-at-9.47.38-am.jpg'
      
      expect(cat.errors[:age]).to_not be_empty
    end
    it "must contain an enjoys" do
      cat = Cat.create name:'Toby Keith', age:42, image:'https://wp.usatodaysports.com/wp-content/uploads/sites/88/2020/06/screen-shot-2020-06-03-at-9.47.38-am.jpg'
     
      expect(cat.errors[:enjoys]).to_not be_empty
    end
    it "must contain an image" do
      cat = Cat.create name:'Toby Keith', age:42, enjoys:'surfing on the beach with all the bro cats'
      
      # p cat.errors[:image]
      # p "ERRORS ARE HERE"

      expect(cat.errors[:image]).to_not be_empty
      # expect the Cat object to have a key called Errors that has a nested key by the name image. Errors.image should have some kind of response that let's me know it is not allowed. 
    end
    it "enjoys must have minimum length of ten" do
      cat = Cat.create name:'Toby Keith', age:42,enjoys:'surfing', image:'https://wp.usatodaysports.com/wp-content/uploads/sites/88/2020/06/screen-shot-2020-06-03-at-9.47.38-am.jpg'
     
      expect(cat.errors[:enjoys]).to_not be_empty
    end
  end
    
end
