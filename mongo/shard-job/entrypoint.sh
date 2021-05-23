kubectl wait --for=condition=ready pod -n $MONGOS_NAMESPACE -l role=mongos

kubectl exec -n $MONGOS_NAMESPACE -l role=mongos -it -- bash

mongo --port 43000 --bind_ip localhost