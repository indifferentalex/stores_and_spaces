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

    it "is not valid without a store" do
      subject.store = nil

      expect(subject).to_not be_valid
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

    it "should cost 100.00 for one day" do
      expect(subject.price(Date.parse("01/01/1995"), Date.parse("01/01/1995"))).to eq(100.00)
    end

    it "should cost 300.00 for three days" do
      expect(subject.price(Date.parse("01/01/1995"), Date.parse("03/01/1995"))).to eq(300.00)
    end

    it "should cost 500.00 for one week" do
      expect(subject.price(Date.parse("01/01/1995"), Date.parse("07/01/1995"))).to eq(500.00)
    end

    it "should cost 700.00 for one week and two days" do
      expect(subject.price(Date.parse("01/01/1995"), Date.parse("09/01/1995"))).to eq(700.00)
    end

    it "should cost 1500.00 for one month" do
      expect(subject.price(Date.parse("01/01/1995"), Date.parse("30/01/1995"))).to eq(1500.00)
    end

    it "should cost 1600.00 for one month and one day" do
      expect(subject.price(Date.parse("01/01/1995"), Date.parse("31/01/1995"))).to eq(1600.00)
    end

    it "should cost 2000.00 for one month and one week" do
      expect(subject.price(Date.parse("01/01/1995"), Date.parse("06/02/1995"))).to eq(2000.00)
    end

    it "should cost 2200.00 for one month and one week and two days" do
      expect(subject.price(Date.parse("01/01/1995"), Date.parse("08/02/1995"))).to eq(2200.00)
    end
  end
end