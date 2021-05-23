kubectl rollout status --watch --timeout=600s statefulset/cfg-svr -n kursach

sleep 12

printf "sh.addShard(\"rs0/rs0-0.rs0.$RS_NAMESPACE.svc.cluster.local:27017, rs0-1.rs0.$RS_NAMESPACE.svc.cluster.local:27017, rs0-2.rs0.$RS_NAMESPACE.svc.cluster.local:27017\")
sh.addShard(\"rs1/rs1-0.rs1.$RS_NAMESPACE.svc.cluster.local:27017, rs1-1.rs1.$RS_NAMESPACE.svc.cluster.local:27017, rs1-2.rs1.$RS_NAMESPACE.svc.cluster.local:27017\")
sh.enableSharding(\"$SHARD_DATABASE_NAME\")
use $SHARD_DATABASE_NAME
db.$SHARD_DATABASE_NAME.createIndex( { number : 1 } )
sh.shardCollection("$SHARD_DATABASE_NAME.$SHARD_COLLECTION_NAME", {departure_delay : "1"})
exit" | mongo --host $MONGOS_SVC_NAME.$MONGOS_NAMESPACE.svc.cluster.local
