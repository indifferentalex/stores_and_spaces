require 'rails_helper'

RSpec.describe 'Stores API', type: :request do
  context "with a single store" do
    before do
      @store = Store.create!(title: "Lidl",
                             city: "Berlin",
                             street: "Kurfürstendamm 1")

      @space = Space.create!(store: @store,
                             title: "Corner near registers",
                             size: 6,
                             price_per_day: 100.00,
                             price_per_week: 500.00,
                             price_per_month: 1500.00)
    end

    describe "GET /stores" do
      before { get "/stores" }

      it "returns stores" do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it "returns a 200 status" do
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /stores/:id" do
      context "when the store exists" do
        before { get "/stores/#{@store.id}" }

        it "returns the store" do
          expect(json).not_to be_empty
          expect(json["id"]).to eq(@store.id)
        end        

        it "returns a 200 status" do
          expect(response).to have_http_status(200)
        end
      end

      context "when the store does not exist" do
        before { get "/stores/42" }

        it "returns a 404 status" do
          expect(response).to have_http_status(404)
        end
      end

      context "when the store exists and there is a space" do
        before { get "/stores/#{@store.id}" }
        
        it "returns the spaces_count" do
          expect(json).not_to be_empty
          expect(json["spaces_count"]).to eq(1)
        end 
      end
    end

    describe "POST /stores" do
      let(:valid_attributes) { { title: "Aldi",
                                 city: "Berlin",
                                 street: "Kurfürstendamm 2" } }

      context "when the request is valid" do
        before { post "/stores", params: valid_attributes }

        it "creates a store" do
          expect(json["title"]).to eq("Aldi")
        end

        it "returns a 201 status" do
          expect(response).to have_http_status(201)
        end
      end

      context "when the request is invalid" do
        before { post "/stores", params: { title: "Auchan" } }

        it "returns a 422 status" do
          expect(response).to have_http_status(422)
        end
      end
    end

    describe "PUT /stores/:id" do
      let(:valid_attributes) { { title: "Adidas" } }

      context "when the record exists" do
        before { put "/stores/#{@store.id}", params: valid_attributes }

        it "updates the record" do
          expect(json["title"]).to eq("Adidas")
        end

        it "returns a 204 status" do
          expect(response).to have_http_status(200)
        end
      end
    end

    describe "DELETE /stores/:id" do
      before { delete "/stores/#{@store.id}" }

      it "deletes the record" do
        expect(response.body).to be_empty
      end      

      it "returns a 204 status" do
        expect(response).to have_http_status(204)
      end
    end    
  end

  context "with a couple of stores" do
    before do
      Store.create!(title: "Lidl",
                    city: "Berlin",
                    street: "Kurfürstendamm 1")

      Store.create!(title: "Aldi",
                    city: "Berlin",
                    street: "Kurfürstendamm 2")
    end

    describe "GET /stores" do
      before { get "/stores" }

      it "returns stores" do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end
    end

    describe "GET /stores?title=eq:Auchan" do
      before { get "/stores?title=eq:Auchan" }

      it "does not return any stores" do
        expect(json).to be_empty
      end
    end    

    describe "GET /stores?title=eq:Aldi" do
      before { get "/stores?title=eq:Aldi" }

      it "returns a single store" do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end
    end

    describe "GET /stores?title=like:Ald_" do
      before { get "/stores?title=like:Ald_" }

      it "returns a single store" do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end
    end
  end 
end