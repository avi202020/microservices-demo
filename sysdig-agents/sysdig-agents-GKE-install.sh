#Update the access_key below
access_key=759c8d66-dd32-499a-aaa9-a71bfe6dd90d

echo "*******************Creating namespace sysdig-agents*******************"
kubectl create namespace sysdig-agents

echo "*******************creating secret for access_key*******************"
kubectl create secret generic sysdig-agent --from-literal=access-key=$access_key -n sysdig-agents

echo "*******************Grant your user the ability to create roles in GKE*******************"
kubectl create clusterrolebinding your-user-cluster-admin-binding --clusterrole=cluster-admin --user=sam.gabrail@sysdig.com

echo "*******************creating clusterrole*******************"
kubectl apply -f sysdig-agent-clusterrole.yaml -n sysdig-agents

echo "*******************creating service account*******************"
kubectl create serviceaccount sysdig-agent -n sysdig-agents

echo "*******************Creating clusterrole binding*******************"
kubectl create clusterrolebinding sysdig-agent --clusterrole=sysdig-agent --serviceaccount=sysdig-agents:sysdig-agent

echo "*******************Deploying Agent Config*******************"
kubectl apply -f sysdig-agent-configmap.yaml -n sysdig-agents

echo "*******************Deploying Agents*******************"
kubectl apply -f sysdig-agent-daemonset-v2-ebpf.yaml -n sysdig-agents

echo "*******************It will take about two minutes for the agents to come up.  HAPPY HACKING*******************"
