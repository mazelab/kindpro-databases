inital-deploy-root-app:
	@helm template charts/_setup-root | kubectl apply -f -
delete-root-app:
	@helm template charts/_setup-root | kubectl delete -f -
get-initial-argo-password:
	kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

get-mysql-password:
	kubectl get secret mysql-auth -o jsonpath="{.data.mysql-root-password}" | base64 -d

.PHONY: start-mysql
start-mysql:
	@helm template --set databases.mysql=true charts/_setup-root | kubectl apply -f -

.PHONY: stop-mysql
stop-mysql:
	@helm template --set databases.mysql=false charts/_setup-root | kubectl delete -f -
