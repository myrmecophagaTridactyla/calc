## Notes

1. Build the test container /
  docker build -f Dockerfile.test -t 10.100.198.200/calc-tests .

2. run the test container /
  docker-compose run --rm calc-tests

3. Build the calc container / 
  docker build -t 10.100.198.200/calc-app .

4. run the calc container /
  docker-compose up -d calc-app
