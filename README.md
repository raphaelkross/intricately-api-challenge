# README

This is a test API where the user is able to create DNS Records and assign them to specific hostnames, besides that you can filter the records with page, include and exclude filters - featuring a related hostnames functionality.

### Requirements

To run this example you will need to install in your machine the following requirements:

```
- Docker v19 or later
- Docker Compose v1.25 or later
```

This test was developed and tested using Fedora 31 disto. If you find any issue when running in another platform, let me know.

### Installation

Use the following commands to install this application in your local environment.

```ssh
# Start your docker...

# Clone the repo.
$ git clone git@github.com:raphaelkross/intricately-api-challenge.git

$ cd intricately-api-challenge

$ docker-compose run --rm web bundle install

$ docker-compose run --rm web yarn install

$ docker-compose up

$ docker-compose exec web ./bin/rails db:create
```

You can see Rails top page on http://localhost:3000/.

### [POST] /api/v1/dns_records

You may find useful the following cURL snippets to add data into your database.

```ssh
curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "1.1.1.1",
		"hostnames_attributes": [
			{
				"hostname": "lorem.com"
			},
			{
				"hostname": "ipsum.com"
			},
			{
				"hostname": "dolor.com"
			},
			{
				"hostname": "amet.com"
			}
		]
	}
}'

curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "2.2.2.2",
		"hostnames_attributes": [
			{
				"hostname": "ipsum.com"
			}
		]
	}
}'

curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "3.3.3.3",
		"hostnames_attributes": [
			{
				"hostname": "ipsum.com"
			},
			{
				"hostname": "dolor.com"
			},
			{
				"hostname": "amet.com"
			}
		]
	}
}'

curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "4.4.4.4",
		"hostnames_attributes": [
			{
				"hostname": "sit.com"
			},
			{
				"hostname": "ipsum.com"
			},
			{
				"hostname": "dolor.com"
			},
			{
				"hostname": "amet.com"
			}
		]
	}
}'

curl --request POST \
  --url http://localhost:3000/api/v1/dns_records \
  --header 'content-type: application/json' \
  --data '{
	"dns_records": {
		"ip": "5.5.5.5",
		"hostnames_attributes": [
			{
				"hostname": "dolor.com"
			},
			{
				"hostname": "sit.com"
			}
		]
	}
}'
```

### [GET] /api/v1/dns_records

A sample on how to query the records.

```ssh
curl --request GET \
  --url 'http://localhost:3000/api/v1/dns_records?page=1&included=ipsum.com%2Cdolor.com&excluded=sit.com' \
  --header 'content-type: application/json'
```
