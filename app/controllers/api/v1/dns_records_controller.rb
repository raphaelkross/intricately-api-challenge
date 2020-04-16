class Api::V1::DnsRecordsController < ActionController::API

  def index
    # Get required param `page`.
    begin
      page = params.require(:page)
    rescue
      return render json: {
        text: "`page` parameter is required."
      }, status: :bad_request
    end

    # Get included/excluded hostnames as an array.
    included = params.include?(:included) ? params[:included].split(',') : []
    excluded = params.include?(:excluded) ? params[:excluded].split(',') : []

    # Get filtered records.
    records = DnsRecord.filter_records(included, excluded, page)

    # Store the formated output.
    dns_records = []

    # Build the expected response to records and related_hostnames.
    dns_records = records.map do |record|
        # Return the expected IP/ID to dns_records.
        { ip_address: record.ip, id: record.id }
    end

    # Final object to be returned.
    results = {
      total_records: dns_records.size,
      records: dns_records,
      related_hostnames: [],
    }

    render json: results.to_json, status: :ok
  end

  def create
    # Filter params.
    begin
      dns_record_params = params.require(:dns_records).permit(:ip, hostnames_attributes: [:hostname])
    rescue
      return render json: {
        text: "`dns_records` parameter is required."
      }, status: :bad_request
    end

    # Create DNS record.
    dns_record = DnsRecord.new(dns_record_params[:ip])

    # Find or Create the hostnames.
    hostnames = []

    dns_record_params[:hostnames_attributes].each do |h|
      hostnames << Hostname.find_or_create_by( { hostname: h[:hostname] } )
    end

    # Assign the hostnames to the DNS record.
    dns_record.hostnames = hostnames

    # Save.
    dns_record.save

    # Check if persisted.
    if ! dns_record.persisted?
      return render json => {
        text: "Failed to save DNS record."
      }, status: :bad_gateway
    end

    # Return new record ID.
    render json: { id: dns_record.id }, status: :ok
  end
end
