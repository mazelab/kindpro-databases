inital-deploy-root-app:
	@helm template charts/_setup-root | kubectl apply -f -
delete-root-app:
	@helm template charts/_setup-root | kubectl delete -f -
get-initial-argo-password:
	kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
