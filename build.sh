
NAMESPACE=${DOCKER_NS:-trawor}
echo "Start build docker images with namespace: ${NAMESPACE}"

function build(){
  docker build -t "$NAMESPACE/$1" -f "./$1.Dockerfile" ./
}

if [ ! $1 ]; then  
  echo "Will build all images:"
  for d in *.Dockerfile; do 
    build "${d%.Dockerfile}"; 
  done
else
  build $1
fi