kubectl wait --for=condition=ready pod -n $MONGOS_NAMESPACE -l role=mongos

mongo --host $MONGOS_SVC_NAME.$MONGOS_NAMESPACE.svc.cluster.local

sh.addShard("rs0/rs0-0.rs0.$RS_NAMESPACE.svc.cluster.local:27017, rs0-1.rs0.$RS_NAMESPACE.svc.cluster.local:27017, rs0-2.rs0.$RS_NAMESPACE.svc.cluster.local:27017")
sh.addShard("rs1/rs1-0.rs1.$RS_NAMESPACE.svc.cluster.local:27017, rs1-1.rs1.$RS_NAMESPACE.svc.cluster.local:27017, rs1-2.rs1.$RS_NAMESPACE.svc.cluster.local:27017")

sh.enableSharding("$SHARD_DATABASE_NAME")
use $SHARD_DATABASE_NAME

db.$SHARD_DATABASE_NAME.createIndex( { number : 1 } )
