require 'rails_helper'

describe "[POST] dns_records route", :type => :request do

    before do
        body = {
            :dns_records => {
                :iṕ => "7.7.7.7",
                :hostnames_attributes => [
                    {
                        :hostname => "rafael.com"
                    }
                ]
            },
            :as => :json
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        post '/api/v1/dns_records', :params => body.to_json, :headers => headers
      end

    it 'should returns status code 200' do
        expect(response).to have_http_status(:success)
    end

    it 'should returns ID ' do
      body = JSON.parse(response.body)
      expect(body).to have_key("id")
  end

  it 'should return bad request if `dns_records` param is missing' do
    post '/api/v1/dns_records'
    expect(response).to have_http_status(:bad_request)
  end

end
