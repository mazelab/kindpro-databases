inital-deploy-root-app:
	@helm template charts/_setup-root | kubectl apply -f -
delete-root-app:
	@helm template charts/_setup-root | kubectl delete -f -

get-mysql-password:
	kubectl get secret mysql-auth -o jsonpath="{.data.mysql-root-password}" -n kindpro-databases | base64 -d

.PHONY: forward-mysql
forward-mysql:
	@kubectl port-forward svc/mysql 3306:3306 -n kindpro-databases &

.PHONY: start-mysql
start-mysql:
	@kubectl patch application root-databases -p '{"spec":{"source":{"helm":{"valuesObject":{"databases":{"mysql":true}}}}}}' --type=merge -n default

.PHONY: stop-mysql
stop-mysql:
	@kubectl patch application root-databases -p '{"spec":{"source":{"helm":{"valuesObject":{"databases":{"mysql":false}}}}}}' --type=merge -n default

.PHONY: forward-mongodb
forward-mongodb:
	@kubectl port-forward svc/mongodb 27017:27017 -n kindpro-databases &

.PHONY: start-mongodb
start-mongodb:
	@kubectl patch application root-databases -p '{"spec":{"source":{"helm":{"valuesObject":{"databases":{"mongodb":true}}}}}}' --type=merge -n default

.PHONY: stop-mongodb
stop-mongodb:
	@kubectl patch application root-databases -p '{"spec":{"source":{"helm":{"valuesObject":{"databases":{"mongodb":false}}}}}}' --type=merge -n default
