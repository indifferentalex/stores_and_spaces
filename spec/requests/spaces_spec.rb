require 'rails_helper'

RSpec.describe 'Spaces API', type: :request do
  context "with a single store and single space" do
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

    describe "GET /stores/:store_id/spaces" do
      before { get "/stores/#{@store.id}/spaces" }

      it "returns spaces" do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it "returns a 200 status" do
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /stores/:store_id/spaces/:id" do
      context "when the space exists" do
        before { get "/stores/#{@store.id}/spaces/#{@space.id}" }

        it "returns the space" do
          expect(json).not_to be_empty
          expect(json["id"]).to eq(@space.id)
        end        

        it "returns a 200 status" do
          expect(response).to have_http_status(200)
        end
      end

      context "when the space does not exist" do
        before { get "/stores/#{@store.id}/spaces/42" }

        it "returns a 404 status" do
          expect(response).to have_http_status(404)
        end
      end
    end

    describe "POST /spaces" do
      let(:valid_attributes) { { store: @store,
                                 title: "Center aisle",
                                 size: 3,
                                 price_per_day: 50.00,
                                 price_per_week: 300.00,
                                 price_per_month: 900.00 } }

      context "when the request is valid" do
        before { post "/stores/#{@store.id}/spaces", params: valid_attributes }

        it "creates a space" do
          expect(json["title"]).to eq("Center aisle")
        end

        it "returns a 201 status" do
          expect(response).to have_http_status(201)
        end
      end

      context "when the request is invalid" do
        before { post "/stores/#{@store.id}/spaces", params: { title: "Entrance" } }

        it "returns a 422 status" do
          expect(response).to have_http_status(422)
        end
      end
    end

    describe "PUT /stores/:store_id/spaces/:id" do
      let(:valid_attributes) { { title: "Entrance" } }

      context "when the record exists" do
        before { put "/stores/#{@store.id}/spaces/#{@space.id}", params: valid_attributes }

        it "updates the record" do
          expect(json["title"]).to eq("Entrance")
        end

        it "returns a 204 status" do
          expect(response).to have_http_status(200)
        end
      end
    end

    describe "DELETE /stores/:store_id/spaces/:id" do
      before { delete "/stores/#{@store.id}/spaces/#{@space.id}" }

      it "deletes the record" do
        expect(response.body).to be_empty
      end      

      it "returns a 204 status" do
        expect(response).to have_http_status(204)
      end
    end

    describe "GET /stores/:store_id/spaces/:id/price/:start_date/:end_date" do
      context "when the space exists" do
        before { get "/stores/#{@store.id}/spaces/#{@space.id}/price/#{Date.parse('01/01/1995').to_s}/#{Date.parse('01/01/1995').to_s}" }

        it "returns the price" do
          expect(json).not_to be_empty
          expect(json["price"]).to eq("100.0")
        end        

        it "returns a 200 status" do
          expect(response).to have_http_status(200)
        end
      end

      context "when the space does not exist" do
        before { get "/stores/#{@store.id}/spaces/42" }

        it "returns a 404 status" do
          expect(response).to have_http_status(404)
        end
      end
    end
  end  
end