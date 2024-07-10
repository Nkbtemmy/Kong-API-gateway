#!/bin/bash
set -e

# Wait for Kong to be ready
until $(curl --output /dev/null --silent --head --fail http://kong:8001); do
  printf '.'
  sleep 5
done

# Add a service
curl -i -X POST --url http://kong:8001/services/ --data 'name=web-service' --data 'url=http://web:5000'

# Add a route for the service
curl -i -X POST --url http://kong:8001/services/web-service/routes --data 'paths[]=/web-service'
