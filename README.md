# jmeter-amazon-linux

526470662813.dkr.ecr.us-east-1.amazonaws.com/vivasaayi/jmeter-amazon-linux:latest


```
export JMETER_HOME=/Users/rajanp/work/apache-jmeter-5.4.1
export JMETER_BIN=${JMETER_HOME}/bin
export PATH=$PATH:$JMETER_BIN
node app-test.js
```

```
docker build -t vivasaayi/jmeter-amazon-linux .
docker run -p 9000:8080 -it vivasaayi/jmeter-amazon-linux
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'


docker tag vivasaayi/jmeter-amazon-linux:latest 526470662813.dkr.ecr.us-east-1.amazonaws.com/vivasaayi/jmeter-amazon-linux:latest

docker push 526470662813.dkr.ecr.us-east-1.amazonaws.com/vivasaayi/jmeter-amazon-linux:latest
```