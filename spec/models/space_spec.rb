require "rails_helper"

RSpec.describe Space, :type => :model do
  context "given a space" do
  	subject {
	  	store = Store.new(title: "Lidl",
	  										city: "Berlin",
	  										street: "Kurfürstendamm 1")
	    
	    Space.new(store: store,
	    									title: "Corner near registers",
	    									size: 6,
	    									price_per_day: 100.00,
	    									price_per_week: 500.00,
	    									price_per_month: 1500.00)
	  }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a size" do
      subject.size = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a price_per_day" do
      subject.price_per_day = nil

      expect(subject).to_not be_valid
    end
  end
end