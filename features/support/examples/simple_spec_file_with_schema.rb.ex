require "spec_helper"

describe "e-BookMobile API" do
  include Rack::Test::Methods

  describe "/authors" do
    let(:route) { "/authors" }

    describe "GET" do
      let(:response_body) do
        {
          "data" => [
            {
              "id" => 1,
              "first_name" => "String",
              "last_name" => "String"
            },
            {
              "id" => 1,
              "first_name" => "String",
              "last_name" => "String"
            }
          ],
          "success" => true,
          "status" => 200
        }.to_json
      end

      it "retrieve a list of authors" do
        get route
        expect(last_response.body).to eql response_body
      end

      it "returns status 200" do
        get route
        expect(last_response.status).to eql 200
      end
    end
  end
end