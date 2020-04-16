require 'rails_helper'

describe "[GET] dns_records route", :type => :request do

  it 'should return status code 200' do
      params = {
          :page => 1,
      }

      get '/api/v1/dns_records', :params => params
      expect(response).to have_http_status(:success)
  end

  it 'should return bad request if `page` param is missing' do
    get '/api/v1/dns_records'
    expect(response).to have_http_status(:bad_request)
  end

  it 'should returns all dns records when only page param is passed' do
    params = {
      :page => 1,
    }

    get '/api/v1/dns_records', :params => params

    body = JSON.parse(response.body)

    expect(body["total_records"]).to eq(5)
    expect(body["related_hostnames"].size).to eq(5)
    expect(body["records"].size).to eq(5)
  end

  it 'should filter based on included/excluded params' do
    params = {
      :page => 1,
      :included => "ipsum.com,dolor.com",
      :excluded => "sit.com",
    }

    get '/api/v1/dns_records', :params => params

    body = JSON.parse(response.body)

    expect(body["total_records"]).to eq(2)
    expect(body["related_hostnames"].size).to eq(2)
    expect(body["records"].size).to eq(2)

    expect(body["records"]).to eq([
      {
        "ip_address" => "1.1.1.1",
        "id" => 1,
      },
      {
        "ip_address" => "3.3.3.3",
        "id" => 3,
      },
    ])

    expect(body["related_hostnames"]).to eq([
      {
        "hostname" => "lorem.com",
        "count" => 1,
      },
      {
        "hostname" => "amet.com",
        "count" => 2,
      },
    ])
  end

end
