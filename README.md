
### Build and Push Docker Image

`source .env.prod`
`docker build --build-arg OWLCMS_JAR_URL=$OWLCMS_JAR_URL -t owlcms:$OWLCMS_VERSION .`

`docker tag owlcms:$OWLCMS_VERSION the646project/owlcms:$OWLCMS_VERSION`
`docker run --env-file .env.file -p 8080:8080 the646project/owlcms:$OWLCMS_VERSION`

`docker login`
`docker push the646project/owlcms:$OWLCMS_VERSION`

### First time deployment to Digital Ocean

https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-on-digitalocean-kubernetes-using-helm

- Make a copy of `owlcms-service-deployment-dev.yaml` and rename it to `owlcms-service-deployment-prod.yaml` with all the prod values
- Make a copy of `production-issuer-dev.yaml` and rename it to `production-issuer-prod.yaml` with valid email

### Update Digital Ocean K8 Cluster

- Update the docker image tag (`spec > containers > image`) - Same as `echo $OWLCMS_VERSION`

`doctl auth init`
`kubectl apply -f owlcms-service-deployment-prod.yaml -n owlcms`

### Key Commands

Restart Cluster
```
kubectl scale deployment owlcms-dep --replicas=0 -n owlcms
kubectl scale deployment owlcms-dep --replicas=1 -n owlcms
```
