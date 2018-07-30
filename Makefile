# Makefile for K8s Cluster Management

include .env

TEMPLATES_DIR=templates
RESULTS_DIR=results

prepare:
	go get -u github.com/bborbe/teamvault-utils/cmd/teamvault-config-dir-generator

use:
	kubectl config use-context c1

generate:
	@rm -rf ${RESULTS_DIR_NAME}
	teamvault-config-dir-generator \
		-source-dir=${TEMPLATES_DIR} \
		-target-dir=${RESULTS_DIR} \
		-logtostderr \
		-v=2

apply: use generate
	@kubectl apply --recursive -f results
	@rm -rf results

clean:
	@rm -rf results
