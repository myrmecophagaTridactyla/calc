## Notes

1. Build the test container

  `docker build -f Dockerfile.test -t 10.100.198.200:5000/calc-tests .`

2. run the test container

  `docker-compose run --rm calc-tests`

3. Build the app container

  `docker build -t 10.100.198.200:5000/calc-app .`

4. run the app container

  `docker-compose up -d calc-app`

5. Push the test container to the registry

  `docker push 10.100.198.200:5000/calc-tests`
  
6. Push the app container to the registry

  `docker push 10.100.198.200:5000/calc-app`
