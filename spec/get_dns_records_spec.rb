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

end
