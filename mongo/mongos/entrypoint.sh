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

kubectl wait --for=condition=ready pod -n $CFG_SVR_NAMESPACE --all

mongos --configdb configReplSet/$CFG_SVR_NAME-0.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017,$CFG_SVR_NAME-1.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017,$CFG_SVR_NAME-2.$CFG_SVR_SVC.$CFG_SVR_NAMESPACE.svc.cluster.local:27017