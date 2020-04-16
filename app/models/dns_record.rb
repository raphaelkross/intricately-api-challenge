class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames

  def self.filter_records( included, excluded, page )

    # Define if record IDs must be filtered or not.
    if included.empty?
      # No need to filter, included hostnames is empty.
      included_records_ids = DnsRecord.all.pluck(:id)
    else
      # Need to filter records that has all included hostnames.
      included_records_ids = DnsRecord.joins(:hostnames)
        .where( "hostnames.hostname":  included )
        .group("id")
        .having("count(dns_records.id) = ?", included.size)
        .pluck(:id)
    end

    # Define the excluded records IDs.
    if excluded.empty?
      excluded_records_ids = []
    else
      excluded_records_ids = DnsRecord.distinct.joins(:hostnames)
        .where( "hostnames.hostname": excluded )
        .pluck(:id)
    end

    # The diff will be the records we want filtered.
    records_ids = included_records_ids - excluded_records_ids

    # Return actual records resources
    DnsRecord.includes(:hostnames).where( id: records_ids )
end
end
