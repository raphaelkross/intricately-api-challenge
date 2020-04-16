class Api::V1::DnsRecordsController < ActionController::API

  def create
      # Return new record ID.
      render json: {}, status: :ok
  end
end
