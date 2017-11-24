require "rails_helper"

RSpec.describe Store, :type => :model do
  subject {
    store = Store.new(title: "Lidl", city: "Berlin", street: "Kurfürstendamm 1")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil

    expect(subject).to_not be_valid
  end

  it "is not valid without a city" do
    subject.city = nil

    expect(subject).to_not be_valid
  end

  it "is not valid without a street" do
    subject.street = nil

    expect(subject).to_not be_valid
  end
end