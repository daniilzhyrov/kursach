kubectl rollout status --watch --timeout=600s statefulset/cfg-svr -n kursach

mongo --host $MONGOS_SVC_NAME.$MONGOS_NAMESPACE.svc.cluster.local

rs.initiate( { _id: "configReplSet", configsvr: true, members: [
    { _id: 0, host: "$CFG_SVR_NAME-0.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017" },
    { _id: 1, host: "$CFG_SVR_NAME-1.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017" },
    { _id: 2, host: "$CFG_SVR_NAME-2.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017" },
]})

sh.addShard("rs0/rs0-0.rs0.$RS_NAMESPACE.svc.cluster.local:27017, rs0-1.rs0.$RS_NAMESPACE.svc.cluster.local:27017, rs0-2.rs0.$RS_NAMESPACE.svc.cluster.local:27017")
sh.addShard("rs1/rs1-0.rs1.$RS_NAMESPACE.svc.cluster.local:27017, rs1-1.rs1.$RS_NAMESPACE.svc.cluster.local:27017, rs1-2.rs1.$RS_NAMESPACE.svc.cluster.local:27017")

sh.enableSharding("$SHARD_DATABASE_NAME")
use $SHARD_DATABASE_NAME

db.$SHARD_DATABASE_NAME.createIndex( { number : 1 } )
sh.shardCollection("$SHARD_DATABASE_NAME.$SHARD_COLLECTION_NAME", {departure_delay : "1"})