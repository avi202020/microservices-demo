#!/bin/bash
gcloud beta container --project "vibrant-tree-219615" clusters create "sysdig-anthos-demo" --zone "us-central1-a" --no-enable-basic-auth --machine-type "n1-standard-4" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --num-nodes "3" --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autorepair
