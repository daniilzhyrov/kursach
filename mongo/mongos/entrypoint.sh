if [ -z "$CFG_SVR_NAME" ]
then
    echo "\$CGF_SVR_NAME is empty"
    exit 1
fi

if [ -z "$CFG_SVR_SVC" ]
then
    echo "\$CGG_SVR_SVC is empty"
    exit 1
fi

if [ -z "$CFG_SVR_NAMESPACE" ]
then
    echo "\$CFG_SVR_NAMESPACE is empty"
    exit 1
fi

kubectl rollout status --watch --timeout=600s statefulset/cfg-svr -n kursach

printf "rs.initiate( { _id: \"configReplSet\", configsvr: true, members: [
    { _id: 0, host: \"$CFG_SVR_NAME-0.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017\" },
    { _id: 1, host: \"$CFG_SVR_NAME-1.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017\" },
    { _id: 2, host: \"$CFG_SVR_NAME-2.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017\" },
]})\nexit"

printf "rs.initiate( { _id: \"configReplSet\", configsvr: true, members: [
    { _id: 0, host: \"$CFG_SVR_NAME-0.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017\" },
    { _id: 1, host: \"$CFG_SVR_NAME-1.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017\" },
    { _id: 2, host: \"$CFG_SVR_NAME-2.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017\" },
]})\nexit" | mongo --host $CFG_SVR_NAME-0.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local


mongos --bind_ip_all --port 27017 --configdb configReplSet/$CFG_SVR_NAME-0.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017,$CFG_SVR_NAME-1.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017,$CFG_SVR_NAME-2.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017 